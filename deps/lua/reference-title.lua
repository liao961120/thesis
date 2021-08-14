lang = nil

function Meta(m)
  lang = pandoc.utils.stringify(m.language)
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
