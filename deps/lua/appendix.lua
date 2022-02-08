function Header (el)
    if (el.level == 1) and (el.classes[1] == "appendix") then
        t = pandoc.utils.stringify(el.content)
        if FORMAT:match 'latex' then
        	t = pandoc.RawBlock("latex", "\\appendix{" .. el.attributes.name .."}{" .. t .. "}")
        	return pandoc.List({t})
        else
    		t = pandoc.RawInline("html", "Appendix " .. el.attributes.name .. "&nbsp;&nbsp;&nbsp;" .. t)
    		return pandoc.Header(1, t, el.attr)
    	end
    end
    return el
  end
