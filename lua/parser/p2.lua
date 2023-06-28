-- trim leading and trailing white space from s
local function trim(s)
    return s:match'^%s*(.*%S)' or ''
  end
  

  local function parse_header(line)
      local level = 0
      while line:sub(1, 1) == "#" do
          level = level + 1
          line = line:sub(2)
      end
      return "<h" .. level .. ">" .. trim(line) .. "</h" .. level .. ">"
  end
  
  -- convert Markdown text to HTML
  local function parse_markdown(markdown_text)
      local lines = {}
      local table_header = false
      local in_table = false
      local code_block_start = false
      for line in markdown_text:gmatch("[^\n]+") do
          if line:match("^#") then
              table.insert(lines, parse_header(line))
              in_table = false
            elseif line:match("^|") then
                if not in_table then
                    in_table = true
                    table_header = true
                    table.insert(lines, "<table>")
                    table.insert(lines, "<tr>")
                end
                -- Split line on "|" character
                local cols = {}
                for col in line:gmatch("%s+(.-)%s*|") do
                    table.insert(cols, trim(col))
                end
                if table_header then
                    -- Add table header
                    for _, col in ipairs(cols) do
                        table.insert(lines, "<th>" .. col .. "</th>")
                    end
                    table.insert(lines, "</tr>")
                    table_header = false

                else
                    -- Add table row
                    table.insert(lines, "<tr>")
                    for _, col in ipairs(cols) do
                        table.insert(lines, "<td>" .. col .. "</td>")
                    end
                    table.insert(lines, "</tr>")
                end
            
            else
                if in_table then
                    in_table = false
                    table.insert(lines, "</table>")
                end
                
        
              -- Check for bold
              line = line:gsub("%*%*(.-)%*%*", "<strong>%1</strong>")
              -- Check for italic
              line = line:gsub("%*(.-)%*", "<em>%1</em>")
              -- Check for strikethrough
              line = line:gsub("~~(.-)~~", "<del>%1</del>")
              -- Check for blockquote
              line = line:gsub("^%s*>%s*(.*)", "<blockquote>%1</blockquote>")
              -- Check for links
              line = line:gsub("%[(.-)%]%((.-)%)", "<a href='%2'>%1</a>")
              -- Check for images
              line = line:gsub("!%[(.-)%]%((.-)%)", "<img src='%2' alt='%1'>")
              -- Check for code
              --line = line:gsub("%`(.-)%`", "<code>%1</code>")
              -- Check for code blocks
              line = line:gsub("`([^`]+)`", "<code>%1</code>")   
              if line:match("^```") then
                  if code_block_start then
                      code_block_start = false
                      table.insert(lines, "</code></pre>")
                  else
                      code_block_start = true
                      table.insert(lines, "<pre><code>")
                  end           
                end
              table.insert(lines, "<p>" .. trim(line) .. "</p>")
          end
      end
      if in_table then
        in_table = false
        table.insert(lines, "</tbody></table>")
    end
      return table.concat(lines, "\n")
  end
  
  -- read in the md from a file
  local markdown_text = io.open("test.md"):read("*all")
  
  -- convert md to html
  local html_text = parse_markdown(markdown_text)
  
  -- write the resulting html to a file
  io.open("output.html", "w"):write(html_text)