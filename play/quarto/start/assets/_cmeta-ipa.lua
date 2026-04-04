-- commands.lua
-- Combined filter: YAML vars injection + IPA font switching.
--
-- Quarto processes metadata before Lua filters run, so metadata
-- arrives as plain Lua tables with {t=..., c=...} fields rather
-- than Pandoc API objects. We walk those tables directly.
--
-- YAML key   -> LaTeX command
-- title      -> \doctitle
-- subtitle   -> \docsubtitle
-- author     -> \docauthor
-- date       -> \docdate
-- cmeta      -> \docmeta   (rich: links become \protect\href)
-- cfoot      -> \docfoot   (rich: links become \protect\href)
-- logoleft   -> \doclogoleft
-- logoright  -> \doclogoright


-- ---------------------------------------------------------------------------
-- IPA helpers
-- ---------------------------------------------------------------------------

local function is_ipa(cp)
  return (cp >= 0x0250 and cp <= 0x02FF)
      or (cp >= 0x1D00 and cp <= 0x1D7F)
end

local function has_ipa(s)
  for _, cp in utf8.codes(s) do
    if is_ipa(cp) then return true end
  end
  return false
end

local function split_segments(s)
  local segments = {}
  local current = ""
  local current_is_ipa = nil
  for _, cp in utf8.codes(s) do
    local char = utf8.char(cp)
    local this_is_ipa = is_ipa(cp)
    if current_is_ipa == nil then current_is_ipa = this_is_ipa end
    if this_is_ipa ~= current_is_ipa then
      table.insert(segments, { text = current, ipa = current_is_ipa })
      current = ""
      current_is_ipa = this_is_ipa
    end
    current = current .. char
  end
  if current ~= "" then
    table.insert(segments, { text = current, ipa = current_is_ipa })
  end
  return segments
end


-- ---------------------------------------------------------------------------
-- AST table walker
-- Quarto flattens metadata into plain {t, c} Lua tables before filters run.
-- We recurse through these directly to produce LaTeX strings.
-- ---------------------------------------------------------------------------

local function walk_inlines(inlines)
  local out = {}
  for _, el in ipairs(inlines) do
    local t = el.t
    if t == "Str" then
      table.insert(out, el.c)
    elseif t == "Space" then
      table.insert(out, " ")
    elseif t == "SoftBreak" or t == "LineBreak" then
      table.insert(out, " \\newline ")
    elseif t == "Link" then
      -- Pandoc Link AST: c = { attr, [inlines], {url, title} }
      local content = el.c[2]
      local target  = el.c[3]
      local url     = type(target) == "table" and target[1] or tostring(target)
      local text    = table.concat(walk_inlines(content))
      url = url:gsub("%%", "\\%%")
      table.insert(out, "\\protect\\href{" .. url .. "}{" .. text .. "}")
    elseif t == "Emph" then
      table.insert(out, "\\emph{" .. table.concat(walk_inlines(el.c)) .. "}")
    elseif t == "Strong" then
      table.insert(out, "\\textbf{" .. table.concat(walk_inlines(el.c)) .. "}")
    elseif t == "Code" then
      table.insert(out, "\\texttt{" .. el.c[2] .. "}")
    elseif t == "RawInline" and el.c[1] == "latex" then
      table.insert(out, el.c[2])
    end
  end
  return out
end

local function walk_blocks(blocks)
  local parts = {}
  for _, block in ipairs(blocks) do
    local t = block.t
    if t == "Para" or t == "Plain" then
      table.insert(parts, table.concat(walk_inlines(block.c)))
    end
  end
  return parts
end


-- ---------------------------------------------------------------------------
-- Injection helpers
-- ---------------------------------------------------------------------------

local function inject_rich(includes, cmd, value)
  if value == nil or type(value) ~= "table" then return end
  includes:insert(pandoc.RawBlock("latex",
    "% DEBUG " .. cmd .. " type=" .. tostring(value.t)))
  io.stderr:write("META KEY: " .. tostring(value))

  local parts = walk_blocks(value)
  local latex = table.concat(parts, " \\newline ")
  latex = latex:gsub("^%s+", ""):gsub("%s+$", "")
  if latex ~= "" then
    includes:insert(pandoc.RawBlock("latex",
      "\\newcommand{\\" .. cmd .. "}{" .. latex .. "}"))
  end
end

local function inject_plain(includes, cmd, value)
  if value == nil or type(value) ~= "table" then return end
  -- for plain fields, walk_blocks then stringify without link markup
  local str = pandoc.utils.stringify(value)
  if str == "" then
    local parts = walk_blocks(value)
    str = table.concat(parts, " ")
  end
  str = str:gsub("^%s+", ""):gsub("%s+$", "")
  if str ~= "" then
    includes:insert(pandoc.RawBlock("latex",
      "\\newcommand{\\" .. cmd .. "}{" .. str .. "}"))
  end
end


-- ---------------------------------------------------------------------------
-- Filter entry points
-- ---------------------------------------------------------------------------

function Meta(m)
  local includes = m["header-includes"] or pandoc.List()

  inject_plain(includes, "doctitle",    m.title)
  inject_plain(includes, "docsubtitle", m.subtitle)
  inject_plain(includes, "docdate",     m.date)
  inject_rich( includes, "docmeta",     m.params.inline)
  inject_rich( includes, "docmeta",     m.params.plain)
  inject_rich( includes, "docfoot",     m.cfoot)
  inject_plain(includes, "doclogoleft", m.logoleft)
  inject_plain(includes, "doclogoright",m.logoright)

  if m.author then
    local ok, str = pcall(pandoc.utils.stringify, m.author)
    if ok and str ~= "" then
      includes:insert(pandoc.RawBlock("latex",
        "\\newcommand{\\docauthor}{" .. str .. "}"))
    end
  end

  m["header-includes"] = includes
  return m
end

function Str(el)
  if not (FORMAT:match("latex") or FORMAT:match("pdf")) then return el end
  if not has_ipa(el.text) then return el end

  local segments = split_segments(el.text)
  local inlines  = pandoc.List()
  for _, seg in ipairs(segments) do
    if seg.ipa then
      inlines:insert(pandoc.RawInline("latex",
        "{\\ipafont " .. seg.text .. "}"))
    else
      inlines:insert(pandoc.Str(seg.text))
    end
  end
  if #inlines == 1 then return inlines[1] end
  return inlines
end