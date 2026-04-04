-- ipa.lua
-- Wraps IPA characters in {\ipafont ...} at the Pandoc AST level.
-- Requires \newfontfamily\ipafont{Source Sans 3} in loani.tex.
--
-- Handles runs of mixed Latin + IPA within a single Str element
-- by splitting into segments and wrapping only IPA runs.

-- IPA codepoint ranges:
--   U+0250-U+02AF  IPAExtensions
--   U+02B0-U+02FF  SpacingModifierLetters
--   U+1D00-U+1D7F  PhoneticExtensions

-- exit on not-latex
local is_latex = FORMAT:match("latex") or FORMAT:match("pdf")
if not is_latex then return el end
--- 


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

-- Split string into segments: each segment is either all-IPA or no-IPA
local function split_segments(s)
  local segments = {}
  local current = ""
  local current_is_ipa = nil

  for _, cp in utf8.codes(s) do
    local char = utf8.char(cp)
    local this_is_ipa = is_ipa(cp)
    if current_is_ipa == nil then
      current_is_ipa = this_is_ipa
    end
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

function Str(el)
  if not has_ipa(el.text) then return el end

  local segments = split_segments(el.text)
  local inlines = pandoc.List()

  for _, seg in ipairs(segments) do
    if seg.ipa then
      inlines:insert(pandoc.RawInline("latex",
        "{\\ipafont " .. seg.text .. "}"))
    else
      inlines:insert(pandoc.Str(seg.text))
    end
  end

  -- if only one element and it's a Str, return as-is
  if #inlines == 1 then return inlines[1] end
  return inlines
end