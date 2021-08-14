if FORMAT:match 'latex' then
    function Div(el)
        if el.classes[1] == "DItem" then
        -- insert element in front
        table.insert(
            el.content, 1,
            pandoc.RawBlock("latex", "\\item[" .. el.attributes.title .. "]{"))
        -- insert element at the back
        table.insert(
            el.content,
            pandoc.RawBlock("latex", "}"))
        end
        return el
    end
end
