-- meta-to-latex.lua
-- function Meta(m)
--   if m.docmeta then
--     local lines = pandoc.utils.stringify(m.docmeta)
--     -- escape for LaTeX and inject into header
--     local cmd = "\\newcommand{\\docmeta}{" .. lines .. "}"
--     m["header-includes"] = m["header-includes"] or pandoc.List()
--     m["header-includes"]:insert(pandoc.RawBlock("latex", cmd))
--   end
--   return m
-- end

-- vars.lua
function Meta(m)
  local includes = m["header-includes"] or pandoc.List()
  
  if m.foot then
    includes:insert(pandoc.RawBlock("latex",
      "\\newcommand{\\foot}{" .. pandoc.utils.stringify(m.foot) .. "}"))
  end
  
  -- if m.meta then
  --   includes:insert(pandoc.RawBlock("latex",
  --     "\\newcommand{\\meta}{" .. pandoc.utils.stringify(m.meta) .. "}"))
  -- end
 
  if m.meta then
    local lines = pandoc.utils.stringify(m.meta)
    -- escape for LaTeX and inject into header
    local cmd = "\\newcommand{\\meta}{" .. lines .. "}"
    m["header-includes"] = m["header-includes"] or pandoc.List()
    m["header-includes"]:insert(pandoc.RawBlock("latex", cmd))
  end
  if m.logoleft then
    includes:insert(pandoc.RawBlock("latex",
      "\\newcommand{\\logoleft}{" .. pandoc.utils.stringify(m.logoleft) .. "}"))
  end

  if m.logoright then
    includes:insert(pandoc.RawBlock("latex",
      "\\newcommand{\\logoright}{" .. pandoc.utils.stringify(m.logoright) .. "}"))
  end

  m["header-includes"] = includes
  return m
end

-- vars.lua
-- Maps YAML front matter fields to \newcommand definitions
-- injected into header-includes before LaTeX sees them.
--
-- Supported YAML keys → LaTeX commands:
--   title      → \doctitle
--   author     → \docauthor
--   date       → \docdate
--   meta       → \docmeta       (multiline ok, use \\ in value)
--   logoleft   → \doclogoleft   (image path)
--   logoright  → \doclogoright  (image path)

local function inject(includes, cmd, value)
  if value then
    local str = pandoc.utils.stringify(value)
    if str ~= "" then
      includes:insert(pandoc.RawBlock("latex",
        "\\newcommand{\\" .. cmd .. "}{" .. str .. "}"))
    end
  end
end

function HMeta(m)
  local includes = m["header-includes"] or pandoc.List()

  inject(includes, "title",     m.title)
  inject(includes, "author",    m.author)
  inject(includes, "date",      m.date)
  -- inject(includes, "docmeta",      m.meta)
  -- inject(includes, "doclogoleft",  m.logoleft)
  -- inject(includes, "doclogoright", m.logoright)

  m["header-includes"] = includes
  return m
end