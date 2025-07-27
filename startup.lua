if fs.exists("controllerB.lua") then
    shell.run("delete controller.lua")
    shell.run("rename controllerB.lua controller.lua")
end

if fs.exists("appsB.json") then
    shell.run("delete apps.json")
    shell.run("rename appsB.json apps.json")
end

if fs.exists("controller.lua") then
    local input = multishell.launch({}, "controller.lua")
    multishell.setTitle(input, "Controller")
end

--[[if fs.exists("output.lua") then
    local output = multishell.launch({}, "output.lua")
    multishell.setTitle(output, "Output")
    multishell.setFocus(output)
end]]

write("Attempt update? Y // N\n > ")
local yn = string.lower(read())

if string.find(yn, "y") then
    shell.run("wget https://raw.githubusercontent.com/DeactivatedMan/CC-Production/refs/heads/main/controller.lua controllerB.lua")  -- Downloads controller script
    shell.run("wget https://raw.githubusercontent.com/DeactivatedMan/CC-Production/refs/heads/main/machines.json appsB.json")  -- Downloads machines json
    write("Updated! (Or did absolutely nothing other than reset the files..)\nrun 'reboot' to initialise\n")
end