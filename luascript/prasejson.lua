local zh = require("Cryptid-localization-zh_CN/localization/zh_CN")
local en = require("Cryptid-localization-zh_CN/localization/en-us")


local function isTable(value)
    return type(value) == "table"
end

local function isArray(t)
    if not isTable(t) then
        return false
    end

    local count = 0
    for k, v in pairs(t) do
        if type(k) == "number" then
            count = count + 1
            if k ~= count then
                return false
            end
        else
            return false  
        end
    end
    return true  
end

local function table_size(t)
    local count = 0
    for _ in pairs(t) do
        count = count + 1
    end
    return count
end


local function recursive_print(t, indent,is_table)
    indent = indent or 0
    local prefix = string.rep("  ", indent)  -- ????????

    local idx = 0

    for key, value in pairs(t) do
        idx  = idx + 1

        if isArray(value) then 
            if type(key) == "number" then 
                print(prefix .."[")
            else 
                print(prefix .. "\"" ..tostring(key) .. "\"" .. " : [")
            end
            recursive_print(value, indent + 1,true)  -- ??????
            print(prefix .. "]"..(table_size(t) == idx and "" or ","))
        elseif type(value) == "table" then

            print(prefix .. "\"" ..tostring(key) .. "\"" .. " : {")
            recursive_print(value, indent + 1,false)  -- ??????
            print(prefix .. "}"..(table_size(t) == idx and "" or ","))
            
        else
            value = string.gsub(value, "\"", "")
            if is_table then 
                print(prefix .. "\"" ..tostring(value).. "\"" ..(table_size(t) == idx and "" or ","))
            else 
                print(prefix .. "\"" ..tostring(key) .. "\"" .. " : " .. "\"" ..tostring(value).. "\"" ..(table_size(t) == idx and "" or ","))

            end
        end
    end
end


print("{")
if arg[1] == "zh" then
    recursive_print(zh,0,false)
else 
    recursive_print(en,0,false)
end
print("}")