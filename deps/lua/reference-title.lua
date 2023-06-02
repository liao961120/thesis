lang = nil

function Meta(m)
  lang = m.language
  if lang == nil then
    lang = ''
  else
    lang = pandoc.utils.stringify(lang)
  end
  return m
end

function Header (el)
  if (el.level == 1) and (pandoc.utils.stringify(el.content) == "References") then
    if lang == "chinese" then
        el.content = pandoc.List({pandoc.Str("參考文獻")})
    end
  end
  return el
end


-- Change execution order
return {
    { Meta = Meta },        -- (1)
    { Header = Header }     -- (2)
}
