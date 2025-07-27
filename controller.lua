local selected = 1

local file = fs.open("apps.json", "r")
local jsonStr = file.readAll()
file.close()

local data = textutils.unserialiseJSON(jsonStr)

local count = #data

local function wrap(input, min,max)
    if input < min then
        return max
    elseif input > max then
        return min
    else
        return input
    end
end

local function formatText(str, chars)
    str = tostring(str)
    if #str > chars then
        return str:sub(1, chars)
    else
        return str .. string.rep(" ", chars - #str)
    end
end

local function showOptions()
    local file = fs.open("apps.json", "r")
    local jsonStr = file.readAll()
    file.close()

    local data = textutils.unserialiseJSON(jsonStr)

    term.clear()
    for i,entry in ipairs(data) do
        term.setCursorPos((term.getSize()-15)/2,4+i)
        term.setTextColour(colours.lime)
        term.write((i==selected and ">" or " ")..formatText(entry.name,10))
    end
end

showOptions()

while true do
    local event, key, isHeld = os.pullEvent("key")
    if key == keys.w or key == keys.up then
        selected = wrap(selected - 1,1,count)
    elseif key == keys.s or key == keys.down then
        selected = wrap(selected + 1, 1, count)
    elseif key == keys.enter or key == keys.space then
        local file = fs.open("apps.json", "r")
        local jsonStr = file.readAll()
        file.close()

        local data = textutils.unserialiseJSON(jsonStr)

        local app = multishell.launch({}, data.cmd)
        multishell.setTitle(app, data.name)
        multishell.setFocus(app)
    end
    showOptions()
    if isHeld then
        sleep()
    end
end