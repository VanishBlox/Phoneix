--[[System Info]]
Phx = {
    version = "0.5v",
    language = "English", 
    logo = false, -- For the Huge ascii logo
    OS,
    Username,
    color = os.execute("color E")
}
-- //Get Username and OS
-- OS finder
if package.config:sub(1,1) == "\\" then 
    Phx.OS = "Windows"
else 
    Phx.OS = "Unix"
end
-- Username finder
if Phx.OS == "Windows" then
    iopopencommand = "echo %username%"
else 
    iopopencommand = "whoami"
end
local iopopenhandel = io.popen(iopopencommand)
local iopopenresault = iopopenhandel:read("*a")
Phx.Username = iopopenresault.gsub(iopopenresault, "\n", "")
iopopenhandel:close()

--[[Lua Addons crap]]
--//Wait statment(in seconds)
function wait(n)
    if n > 0 then os.execute("ping -n " .. tonumber(n+1) .. " localhost > NUL") end
end


--//list of commandss
commandsList = {
    help = function (args) --Help command
        local helpCommandsListShort = { --for shorter info
            help = "Help // Shows the command list and help for currently available commands.",
            info = "Info // Shows info about Phoniex and the current OS.",
            exit = "Exit // Exits Phoniex terminal."
        }
        
        local helpCommandsListLong = { --full info about usage
            help = "// Help //\n\n//Description//\nShow the commands list if there are no arguments given,\nif a command is given as an arugment it will show help and correct usage for that command.\n\n//Usage//\n\"help [command from command list]\"",
            info = "// Info //\n\n//Description//\nShows info about the current OS that Phoenix is running on, might be buggy.\n\n//Usage//\n\"info\"",
            exit = "// Exit //\n\n//Description//\nShuts the Terminal down with only one command, isn't that handy? :)\n\n//Usage//\n\"exit\"",
        } 
        
        local argumentCounter = 0
        if args ~= nil then argumentCounter = #args end 
        
        if argumentCounter > 1 then print ("//505//: No more than one argument is allowed for this command.")
        
            elseif args == nil then 
                print(helpCommandsListLong["help"] .. "\n\n// Commandlist //\n")
                for i,v in pairs(helpCommandsListShort) do 
                    print(v)
                end
            elseif helpCommandsListLong[args[1]] ~= nil then 
                print(helpCommandsListLong[args[1]])
            
            else print("//404//: \"" .. args[1] .. "\" is not a valid command.")
        end
    end,
    exit = function () --Shutdown command
        print("Signing off...")
        wait(0.5)
        print("Goodbye!")
        os.exit()
    end,
    
    info = function () --Info command
        print("Version: " .. Phx.version 
        .. "\nLanguage: " .. Phx.language 
        .. "\nParent OS: " .. Phx.OS
        .. "\nUsername: " .. Phx.Username)
    end,
    hack = function () -- Showoff, it doesn't actually do anything LOL
        io.write("Script loading")
        for i=1,3 do 
            wait(0.5)
            io.write(".")
        end
        print("")
        print("Hacking:")
        for i=1,100 do
            wait(0.1) 
            print(i .. "%")
        end
        print("Process done! Welcome " .. Phx.Username .. " :))")
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

if Phx.logo == true then
    showLogo()
else 
    print("This is the unstable build PhxTest, current version: [" .. Phx.version .. "]")
end


--//io.read() loop
while true do -- Will loop until the program is stopped
    print("")
    io.write("~* Phoneix/" .. Phx.Username .. ">") 
    local userInputOriginal = io.read() -- Gets the original Userinput 
    local userInput = string.lower(userInputOriginal) -- Makes the user input small caps so it can run the cmds
    
    local userInputList = {} -- the list of arugments 
    local userInputListCount = 0 -- count of userInputList
    
    for argument in string.gmatch(userInput, "[^%s]+") do -- Cuts the userinput into arugments and commands 
        table.insert(userInputList, argument) -- inserts them into userInputList
        userInputListCount = userInputListCount + 1 -- adds 1 to the count for each argument 
    end
    
    if userInputListCount == 1 then -- if only a cmd is called in the userInput

        if commandsList[userInputList[1]] == nil then -- if that cmd doesnt doesnt exist
            print( "// 404 //: The command \"" .. userInputOriginal .. "\" either doesn't exist or is spelled wrong." )
        else -- execute that command
            commandsList[userInputList[1]]()
        end

    elseif userInputListCount > 1 then -- has the userInputed more than one argument?
        local command = userInputList[1] 
        table.remove(userInputList, 1) -- removes the cmd
        commandsList[command](userInputList) 
    end
end