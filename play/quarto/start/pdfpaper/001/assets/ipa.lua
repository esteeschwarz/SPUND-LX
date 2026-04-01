-- ipa.lua
local ipa_pattern = "[\xC9\xCA\xCB\xCC][\x80-\xBF]"  -- rough UTF8 IPA range

-- function Str(el)
--   if el.text:match("[ɪʃɔːʁɛʊɐəɑɒæøœyɯɨɘɵɞɶɷɹɻɼɽɾɿʀʁʂʃʄʅʆʇʈʉʊʋʌʍʎʏʐʑʒʓʔʕʖʗʘʙʚʛʜʝʞʟʠʡʢʣʤʥʦʧʨʩʪʫʬʭʮʯ]") then
--     return pandoc.RawInline("latex", "{\\ipafont " .. el.text .. "}")
--   end
-- end

function Str(el)
  if el.text:match(ipa_pattern) then
    return pandoc.RawInline("latex", "{\\ipafont " .. el.text .. "}")
  end
end