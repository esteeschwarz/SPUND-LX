WITH 
-- Your original token groups in a temp table
temp_token_queries AS (
    /*
    SELECT 1 AS query_id, 'I' AS token UNION ALL
    SELECT 1, 'my' UNION ALL
    SELECT 1, 'me' UNION ALL
    SELECT 1, 'mine' UNION ALL
    SELECT 1, 'myself' UNION ALL
    SELECT 2, 'you' UNION ALL
    SELECT 2, 'your' UNION ALL
    SELECT 2, 'yours' UNION ALL
    SELECT 2, 'yourself' UNION ALL
    SELECT 3, 'he' UNION ALL
    SELECT 3, 'she' UNION ALL
    SELECT 3, 'they' UNION ALL
    SELECT 3, 'his' UNION ALL
    SELECT 3, 'her' UNION ALL
    SELECT 3, 'their'
),*/
    SELECT 1 AS query_id, 'I' AS token, NULL AS upos UNION ALL
    SELECT 1, 'my', NULL UNION ALL
    SELECT 1, 'me', NULL UNION ALL
    SELECT 1, 'mine', NULL UNION ALL
    SELECT 1, 'myself', NULL UNION ALL
    SELECT 2, 'you', NULL UNION ALL
    SELECT 2, 'your', NULL UNION ALL
    SELECT 2, 'yours', NULL UNION ALL
    SELECT 2, 'yourself', NULL UNION ALL
    SELECT 3, 'he', NULL UNION ALL
    SELECT 3, 'she', NULL UNION ALL
    SELECT 3, 'they', NULL UNION ALL
    SELECT 3, 'his', NULL UNION ALL
    SELECT 3, 'her', NULL UNION ALL
    SELECT 3, 'their', NULL UNION ALL
    
    -- New POS tag queries (added below with unique query_ids)
    SELECT 4, 'NOUN', 'NOUN' UNION ALL    -- All nouns
    SELECT 5, 'VERB', 'VERB' UNION ALL    -- All verbs
    SELECT 6, 'ADJ', 'ADJ'               -- All adjectives
),

-- Get corpus counts for each group
corpus_counts AS (
    SELECT 
        t.query_id,
        COUNT(c.token) AS corpus_matches,
        (SELECT COUNT(*) FROM reddit_com_pos) AS corpus_total
    FROM temp_token_queries t
    --LEFT JOIN reddit_com_pos c ON t.token = c.token
        --    (t.token = c.token OR (t.token IS NULL AND t.pos = c.pos))
    
    LEFT JOIN reddit_com_pos c ON 
        (t.token = c.token OR (t.token IS t.token AND t.upos = c.upos))
    GROUP BY t.query_id
),

-- Get reference counts for each group
ref_counts AS (
    SELECT 
        t.query_id,
        COUNT(r.token) AS ref_matches,
        (SELECT COUNT(*) FROM reddit_pos_ref) AS ref_total
    FROM temp_token_queries t
    -- LEFT JOIN reddit_pos_ref r ON t.token = r.token
    
    LEFT JOIN reddit_pos_ref r ON 
        (t.token = r.token OR (t.token IS t.token AND t.upos = r.upos))
    GROUP BY t.query_id
),

-- Combine with statistical calculations
results AS (
    SELECT
        t.query_id,
        GROUP_CONCAT(t.token, ', ') AS tokens_in_group,
        -- Corpus stats
        cc.corpus_matches,
        cc.corpus_total,
        ROUND(cc.corpus_matches * 100.0 / cc.corpus_total, 2) AS corpus_percentage,
        -- Reference stats
        rc.ref_matches,
        rc.ref_total,
        ROUND(rc.ref_matches * 100.0 / rc.ref_total, 2) AS ref_percentage,
        -- Statistical comparisons
        ROUND(cc.corpus_matches * 100.0 / cc.corpus_total - rc.ref_matches * 100.0 / rc.ref_total, 2) AS percentage_diff,
        CASE WHEN rc.ref_matches > 0 
             THEN ROUND((cc.corpus_matches * 1.0 / cc.corpus_total) / (rc.ref_matches * 1.0 / rc.ref_total), 2)
             ELSE NULL END AS percentage_ratio,
        -- Z-score calculation
        (cc.corpus_matches*1.0/cc.corpus_total - rc.ref_matches*1.0/rc.ref_total) / 
        SQRT(
            (cc.corpus_matches+rc.ref_matches)*1.0/(cc.corpus_total+rc.ref_total) * 
            (1 - (cc.corpus_matches+rc.ref_matches)*1.0/(cc.corpus_total+rc.ref_total)) * 
            (1.0/cc.corpus_total + 1.0/rc.ref_total)
        ) AS z_score
    FROM temp_token_queries t
    JOIN corpus_counts cc ON t.query_id = cc.query_id
    JOIN ref_counts rc ON t.query_id = rc.query_id
    GROUP BY t.query_id
)

-- Final output with all stats
SELECT 
    query_id AS group_id,
    tokens_in_group,
    corpus_matches,
    corpus_total,
    corpus_percentage || '%' AS corpus_pct,
    ref_matches,
    ref_total,
    ref_percentage || '%' AS ref_pct,
    percentage_diff || 'pp' AS pct_diff,
    percentage_ratio AS ratio,
    ROUND(z_score, 3) AS z_score,
    CASE 
        WHEN ABS(z_score) > 2.576 THEN '***(p<0.01)'
        WHEN ABS(z_score) > 1.96 THEN '**(p<0.05)'
        WHEN ABS(z_score) > 1.645 THEN '*(p<0.1)'
        ELSE 'not significant'
    END AS significance
FROM results
ORDER BY query_id;