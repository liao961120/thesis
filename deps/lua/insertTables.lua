CUSTOM_TABLES = {}
format = nil

-- Set up global variables
if FORMAT:match 'latex' then
    format = 'latex'
    table_fp = 'chapters/tables.tex'
elseif FORMAT:match 'html' then
    format = 'html'
    table_fp = 'chapters/tables.html'
else
    print("Not latex nor html, skipping filter...")
end


function Div(el)
    if format == nil then return nil end
    -- Insert table defined in tables.tex/tables.html
    get_custom_tables(table_fp)
    local table = CUSTOM_TABLES[el.identifier]
    if table ~= nil then
        caption = get_caption(el.content[1])
        table = create_raw_table(table, caption, el.identifier)
        return pandoc.RawBlock(format, table)
    end

    return nil
end


function create_raw_table(table_text, caption, tbl_id)
    caption = escape_pattern(caption)
    if format == "latex" then
        caption = '\\caption{' .. caption .. '}'
        
        if string.find(table_text, "%%caption%%") then
            -- Custom caption position
            tgt = '%%caption%%'
            repl = caption
        else
            -- Default caption position 
               -- (not guaranteed to work in all cases)
            tgt = [[ \begin{table}[] ]]
            repl = tgt .. "\n" .. caption
        end
        return string.gsub(table_text, tgt, repl)
    elseif format == 'html' then
        caption = '<caption id="' .. tbl_id .. '">'.. caption .. '</caption>'
        tgt = '</table>'
        repl = caption .. tgt
        return string.gsub(table_text, tgt, repl)
    end
    return "UNDEFINED_FORMAT"
end


function get_caption(table)
    for k, v in pairs(table) do
        if k == 'caption' then
            return stringify(v.long[1].content)
        end
    end
    return ""
end

-- Write a parital tree to string, with formats
function stringify(tree)
    local result = {}
    -- Process each node
    local function go(node)
        key = node.tag
        if key == 'Plain' then
            resolve = stringify(node.content)
            result[#result + 1] = resolve
        elseif key == 'Strong' then
            resolve = stringify(node.content)
            result[#result + 1] = writeStrong(resolve)
        elseif key == 'Emph' then
            resolve = stringify(node.content)
            result[#result + 1] = writeEmph(resolve)
        elseif key == 'Link' then
            resolve = stringify(node.content)
            result[#result + 1] = writeLink(resolve, node.target)
        elseif key == 'Str' or key == 'MetaString' then
            result[#result + 1] = escape(node.text)
        elseif key == 'RawInline' then
            result[#result + 1] = node.text
        elseif key == 'Code' then
            result[#result + 1] = writeCode(escape(node.text))
        elseif key == 'Math' then
            result[#result + 1] = writeMath(node.text)
        elseif key == 'Space' or key == "SoftBreak" or key == "LineBreak" then
            result[#result + 1] = " "
        end
    end
    -- Walk tree
    for k, v in pairs(tree) do
        go(v)
    end
    return table.concat(result)
end

-- Writer functions
function escape(x)
    if format ~= 'latex' then return x end
    return x:gsub("%%", "\\%1")
end
function writeStrong(x)
    if format == 'latex' or format == 'tex' then return '\\textbf{' .. x .. '}' end
    if format == 'html' then return '<strong>' .. x .. '</strong>' end
    if format == 'markdown' then return "**" .. x .. "**" end
    return x
end
function writeEmph(x)
    if format == 'latex' or format == 'tex' then return '\\emph{' .. x .. '}' end
    if format == 'html' then return '<em>' .. x .. '</em>' end
    if format == 'markdown' then return "*" .. x .. "*" end
    return x
end
function writeLink(x, link)
    if format == 'latex' or format == 'tex' then 
        return '\\href{' .. link .. '}{' .. x .. '}'
    end
    if format == 'html' then 
        return '<a href="' .. link .. '">' .. x .. '</a>'
    end
    if format == 'markdown' then return "[" .. x .. "](" .. link .. ")" end
    return x
end 
function writeCode(x)
    if format == 'latex' or format == 'tex' then return '\\texttt{' .. x .. '}' end
    if format == 'html' then return "<code>" .. x .. "</code>" end
    if format == 'markdown' then return "`" .. x .. "`" end
    return x
end
function writeMath(x)
    if format == 'latex' or format == 'tex' then return '\\(' .. x .. '\\)' end
    if format == 'html' then return '<span class="math inline">' .. x .. '</span>' end
    if format == 'markdown' then return "$" .. x .. "$" end
    return x
end



-- Read raw table text from tables.tex/tables.html
function get_custom_tables(file)
    if not table.empty(CUSTOM_TABLES) then return nil end
    if not file_exists(file) then return nil end

    if format == 'latex' then
        cmt_s = '%%'
        cmt_e = '%%'
    elseif format == 'html' then
        cmt_s = '<!%-%-'
        cmt_e = '%-%->'
    else
        return nil
    end
    pat_tbl_s = cmt_s .. " tbl:%S+ " .. cmt_e
    pat_tbl_e = cmt_s .. " END  " .. cmt_e
    pat_is_cmt = "^" .. cmt_s

    -- Parse file (tables.tex/tables.html)
    in_table = false
    for line in io.lines(file) do
        if string.find(line, pat_is_cmt) and string.find(line, pat_tbl_s) then
            in_table = true
            i, j = string.find(line, "tbl:%S+")
            tbl_id = string.sub(line, i, j)
            CUSTOM_TABLES[tbl_id] = line
        elseif in_table and string.find(line, pat_is_cmt) and string.find(line, pat_tbl_e) then
            in_table = false
        elseif in_table then
            CUSTOM_TABLES[tbl_id] = CUSTOM_TABLES[tbl_id] .. '\n' .. line
        end
    end
end


-- Helper functions
function escape_pattern(text)
    return text:gsub("%%", "%%%1")
end

local function starts_with(start, str)
    return str:sub(1, #start) == start
  end

function file_exists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
end

function table.empty(self)
    for _, _ in pairs(self) do return false end
    return true
end
