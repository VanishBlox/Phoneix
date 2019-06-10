--[[System Info]]
Phx = {
    version = "0.5v",
    language = "English", 
    logo = "off" -- change it to "off" to turn the logo off, or "on" to turn it back
}
--[[Lua Addons crap]]
--//Wait statment(in seconds)
function wait(n)
    if n > 0 then os.execute("ping -n " .. tonumber(n+1) .. " localhost > NUL") end
end
--//list of commandss
commandsList = {
    help = function (...) --Help command
        print("Use \"cmds\" to show available commands!")
    end,
    cmds = function () --Show commandss
        local commandsListShow = {
            "CMDS    : Shows a list of a available commands",
            "HELP    : Shows help for individual commands",
            "EXIT    : Exit's the program",
            "INFO    : Show Phoneix's Info"
        } 
        for i,v in pairs(commandsListShow) do 
            print(v)
        end
    end,
    exit = function () --Shutdown command
        print("Shutting down...")
        wait(0.5)
        os.exit()
    end,
    info = function () --Info command
        print("Version: " .. Phx.version)
        print("Language: " .. Phx.language)
    end,
}
--[[
    Manuel to adding commands:
    - to add a command you must first name it, must type it in lowercase
    - then you can add the function, the template goes like this:
        cmdname = function () --start of cmd
         --Your code here
        end,
    - That was it, it's pretty easy! :)
]]
--//LOGO
function showLogo() 
    print(" _____________________________________________________________________________")
    print("|                                                                             |")
    print("|  ##      ##  ########  ##         ######    #######   ##     ##  ########   |")
    print("|  ##  ##  ##  ##        ##        ##    ##  ##     ##  ###   ###  ##         |")
    print("|  ##  ##  ##  ##        ##        ##        ##     ##  #### ####  ##         |")
    print("|  ##  ##  ##  ######    ##        ##        ##     ##  ## ### ##  ######     |")
    print("|  ##  ##  ##  ##        ##        ##    ##  ##     ##  ##     ##  ##         |")
    print("|   ###  ###   ########  ########   ######    #######   ##     ##  ########   |")
    print("|                                                                             |")
    print("|                            ########  #######                                |")
    print("|                               ##    ##     ##                               |")
    print("|                               ##    ##     ##                               |")
    print("|                               ##    ##     ##                               |")
    print("|                               ##    ##     ##                               |")
    print("|                               ##     #######                                |")
    print("|                                                                             |")
    print("|   ########   ##     ##   #######   ########  ##    ##  ####  ##     ##(C)   |")
    print("|   ##     ##  ##     ##  ##     ##  ##        ###   ##   ##    ##   ##       |")
    print("|   ##     ##  ##     ##  ##     ##  ##        ####  ##   ##     ## ##        |")
    print("|   ########   #########  ##     ##  ######    ## ## ##   ##      ###         |")
    print("|   ##         ##     ##  ##     ##  ##        ##  ####   ##     ## ##        |")
    print("|   ##         ##     ##  ##     ##  ##        ##   ###   ##    ##   ##       |")
    print("|   ##         ##     ##   #######   ########  ##    ##  ####  ##     ##      |")
    print("|_____________________________________________________________________________|")
end
if Phx.logo == "on" then
    showLogo()
else 
    print("This is the unstable build PhxTest, current version: [" .. Phx.version .. "]")
end
--//io.read() loop
while true do -- Will loop until the program is stopped
    ::start:: -- The start of the while loop
    io.write("> ") 
    local userInputOriginal = io.read() -- Gets the original Userinput 
    if userInputOriginal == "" then print("Please enter a command!") goto start end
    local userInput = string.lower(userInputOriginal) -- Makes the user input small caps so it can run the cmds
    local userInputList = {} -- the list of arugments 
    local userInputListCount = 0 -- count of userInputList
    for argument in string.gmatch(userInput, "[^%s]+") do -- Cuts the userinput into arugments and commands 
        table.insert(userInputList, argument) -- inserts them into userInputList
        userInputListCount = userInputListCount + 1 -- adds 1 to the count for each argument 
    end
    if userInputListCount == 1 then -- if only a cmd is called in the userInput
        if commandsList[userInputList[1]] == nil then -- if that cmd doesnt doesnt exist
            print("404: The command \"" .. userInputOriginal .. "\" either doesn't exist or is spelled wrong." )
        else -- execute that command
            commandsList[userInputList[1]]()
        end
    elseif userInputListCount > 1 then 
            commandsList[userInputList[1]](userInputList[2])
    end
end