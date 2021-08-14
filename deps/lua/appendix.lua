function Header (el)
    if (el.level == 1) and (el.classes[1] == "appendix") then
        t = pandoc.utils.stringify(el.content)
        t = pandoc.RawBlock("latex", "\\appendix{" .. el.attributes.name .."}{" .. t .. "}")
        return pandoc.List({t})
    end
    return el
  end
