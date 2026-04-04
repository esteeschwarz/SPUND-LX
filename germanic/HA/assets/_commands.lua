-- vars.lua
-- Reads YAML front matter and injects \newcommand definitions
-- into header-includes so LaTeX snippets can use \doc... vars
-- without any $var$ Pandoc template syntax.
--
-- YAML key      →  LaTeX command
-- title         →  \doctitle
-- subtitle      →  \docsubtitle
-- author        →  \docauthor      (list joined with ", ")
-- date          →  \docdate
-- meta          →  \docmeta        (rich: links/formatting preserved)
-- foot          →  \docfoot
-- logoleft      →  \doclogoleft    (image path)
-- logoright     →  \doclogoright   (image path)


-- md links

local function process_inlines(inlines)
  local out = pandoc.List()

  for _, inline in ipairs(inlines) do
    if inline.t == "Str" and has_ipa(inline.text) then
      local segments = split_segments(inline.text)

      for _, seg in ipairs(segments) do
        if seg.ipa and FORMAT:match("latex") then
          out:insert(
            pandoc.RawInline("latex",
              "{\\ipafont " .. seg.text .. "}")
          )
        else
          out:insert(pandoc.Str(seg.text))
        end
      end
    else
      out:insert(inline)
    end
  end

  return out
end
--


-- Plain stringify for fields that are always plain text
local function inject(includes, cmd, value)
  if value == nil then return end
  local str = pandoc.utils.stringify(value)
  if str ~= "" then
    includes:insert(pandoc.RawBlock("latex",
      "\\newcommand{\\" .. cmd .. "}{" .. str .. "}"))
  end
end

-- Rich inject: converts Pandoc inlines → LaTeX, preserving
-- links, emphasis etc. Used for \docmeta and \docfoot.
local function inject_rich(includes, cmd, value)
  if value == nil then return end
  includes:insert(pandoc.RawBlock("latex",
    "% DEBUG " .. cmd .. " type=" .. tostring(value.t)))

  -- MetaBlocks: walk each block, convert inlines to LaTeX
  local blocks
  if value.t == "MetaBlocks" then
    blocks = value
  elseif value.t == "MetaInlines" then
    blocks = pandoc.Blocks({ pandoc.Para(value) })
  else
    -- fallback to plain stringify
    inject(includes, cmd, value)
    return
  end

  -- Convert blocks to LaTeX via Pandoc writer
-- local doc = pandoc.Pandoc(blocks, PANDOC_STATE.meta)

-- local latex = pandoc.write(
--   doc,
--   "latex",
--   PANDOC_STATE.writer_options
-- )

-- latex = latex:gsub("\\href", "\\protect\\href")
-- latex = latex:gsub("\\url",  "\\protect\\url")

-- latex = latex:gsub("^%s*\\par%s*", "")
--              :gsub("%s*\\par%s*$", "")
--              :gsub("^%s+", "")
--              :gsub("%s+$", "")
--                             :gsub("anarkkiv", "ada")

  local doc = pandoc.Pandoc(blocks)
  local latex = pandoc.write(doc, "latex")
  latex = latex:gsub("\\href", "\\protect\\href")
  -- Strip surrounding \par / newlines Pandoc adds around blocks
  latex = latex:gsub("^%s*\\par%s*", "")
               :gsub("%s*\\par%s*$", "")
               :gsub("^%s+", "")
               :gsub("%s+$", "")
                                           :gsub("anarkkiv", "ada")

              --  :gsub("\\href(%b{})(%b{})", "\\mbox{\\href%1%2}")

  if latex ~= "" then
    includes:insert(pandoc.RawBlock("latex",
      "\\newcommand{\\" .. cmd .. "}{" .. latex .. "}"))
  end
end

function Meta(m)
  local includes = m["header-includes"] or pandoc.List()

  inject(includes,      "doctitle",     m.title)
  inject(includes,      "docsubtitle",  m.subtitle)
  inject(includes,      "docdate",      m.date)
  inject_rich(includes, "docmeta",      m.cmeta)   -- rich: preserves links
  inject_rich(includes, "docfoot",      m.cfoot)   -- rich: preserves links
  inject(includes,      "doclogoleft",  m.logoleft)
  inject(includes,      "doclogoright", m.logoright)

  -- author: join list into single string
  if m.author then
    local authors
    if type(m.author) == "table" and m.author.t == "MetaList" then
      local parts = {}
      for _, a in ipairs(m.author) do
        table.insert(parts, pandoc.utils.stringify(a))
      end
      authors = table.concat(parts, ", ")
    else
      authors = pandoc.utils.stringify(m.author)
    end
    if authors ~= "" then
      includes:insert(pandoc.RawBlock("latex",
        "\\newcommand{\\docauthor}{" .. authors .. "}"))
    end
  end

  m["header-includes"] = includes
  return m
end