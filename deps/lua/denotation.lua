if FORMAT:match 'latex' then
    function Div(el)
        if el.classes[1] == "Denotation" then
        -- insert element in front
        table.insert(
            el.content, 1,
            pandoc.RawBlock("latex", "\\begin{denotation}[3cm]"))
        -- insert element at the back
        table.insert(
            el.content,
            pandoc.RawBlock("latex", "\\end{denotation}"))
        end
        return el
    end
end
