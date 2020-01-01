--[[System Info]]
Phx = {
    version = 0.6,
    language = "English", 
    logo = false, -- For the Huge ascii logo
    OS,
    Username,
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
function wait(s)
    local ntime = os.time() + s
    repeat until os.time() > ntime
end
--[[
--//Error function 
function error(error_type, error_description)
    local error_typeList = {
        unauthorized = 400,
        bad_argument = 404,
        many_arugments = 402,
    }
    if error_type or error_description == nil then 
        print("error_type or error_description were not entered!") 
    else 
        print(os.date() .. )
    end
end
--]]

--//Color function
colorPalette = {
    black           = 0, 
    blue            = 1,    
    green           = 2, 
    turquoise       = 3,     
    red             = 4, 
    purple          = 5, 
    yellow          = 6, 
    light_gray      = 7,    
    gray            = 8, 
    light_blue      = 9, 
    light_green     = "A", 
    light_turquoise = "B", 
    light_red       = "C", 
    light_purple    = "D", 
    light_yellow    = "E", 
    white           = "F", 
}

--//list of commandss
commandsList = {
    help = function (args) --Help command
        local helpCommandsListShort = { --for shorter info
            help = "Help \t\t// Shows the command list and help for currently available commands.",
            info = "Info \t\t// Shows info about Phoniex and the current OS.",
            exit = "Exit \t\t// Exits Phoniex terminal.",
            discordparser = "Discordparser \t// Parsers through Discord XML code to find out Profilepic, Username and Status.",
            robloxid = "Robloxid \t// Fills out a template for orginazing Roblox Song IDs.",
            lua = "Lua \t\t// Opens the Lua command line or a Lua script in a new window.",
            start = "Start \t\t// Opens the app that is given in the first argument, Opens with an argument if two arguments are given.",
        }
        
        local helpCommandsListLong = { --full info about usage
            help = "// Help //\n\n//Description//\nShow the commands list if there are no arguments given,\nif a command is given as an arugment it will show help and correct usage for that command.\n\n//Usage//\n\"help [command from command list]\"",
            info = "// Info //\n\n//Description//\nShows info about the current OS that Phoenix is running on, might be buggy.\n\n//Usage//\n\"info\"",
            exit = "// Exit //\n\n//Description//\nShuts the Terminal down.\n\n//Usage//\n\"exit\"",
            discordparser = "// Discordparser //\n\n//Description//\nParses through given Discord XML code from the dev console, and then prints the resaults if no argument is specified, otherwise prints the specifed argument.\n\n//Usage//\n\"discordparser [a vaild argument]\"\n\n// Arguments //\nNone \t\t// Will print all the resualts\nProfilepic \t// URL to profile picture\nUsername \t// The Discord Username\nStatus \t\t// The current status of the User",
            robloxid = "// Robloxid //\n\n//Description//\n Creates a template than you can copy paste and use on Discord, URL and name for song must be given.\n\n//Usage//\n\"robloxid [url of song, not necessary since it will ask for it again if not given]\"",
            lua = "// Lua //\n\n//Description//\nStarts a new Lua command line if no path is given, if a path is given then it will start in a new window.\n\n//Usage//\n\"lua [path, if none is given then it will start a new lua command line]\"",
            start = "// Start //\n\n//Description//\nStarts an app which is given in the first argument, will pass the second argument as the first argument if it is existing.\n\n//Usage//\n\"start [app or path] [addiotnal path or argument if it is given]\"",
        } 
        
        local argumentCounter = 0
        if args ~= nil then argumentCounter = #args end 
        
        if argumentCounter > 1 then print ("//505//: No more than one argument is allowed for this command.")
        
            elseif args == nil then 
                print(helpCommandsListLong["help"] .. "\n\n// Commandlist //\n")
                for i,v in pairs(helpCommandsListShort) do 
                    print(v)
                end
            elseif helpCommandsListLong[string.lower(args[1])] ~= nil then 
                print(helpCommandsListLong[string.lower(args[1])])
            
            else print("//404//: \"" .. args[1] .. "\" is not a valid command.")
        end
    end,
    exit = function () --Shutdown command
        print("Signing off...")
        wait(0.2)
        print("Goodbye!")
        os.exit()
    end,
    
    info = function () --Info command
        print("Version: \t" .. Phx.version 
        .. "\nLanguage: \t" .. Phx.language 
        .. "\nParent OS: \t" .. Phx.OS
        .. "\nUsername: \t" .. Phx.Username)
    end,
    hack = function () -- Showoff, it doesn't actually do anything LOL
        io.write("Script loading")
        for i=1,3 do 
            wait(0.5)
            io.write(".")
        end
        print("")
        print("Doing absloutely nothing")
        for i=1,100 do
            print(i .. "%")
        end
        print("Process done! Welcome " .. Phx.Username .. " :))")
    end,
    discordparser = function (args) -- Used for Parsing Status, username or profile out of the XML code from Discord dev console
        local info = { -- info for the parser
            username = false,
            status = false,
            profilepic = false,
        }
        
        local function XmlParser() -- For parsing the given code so it can get the Username, Status, and Profilepic
            print("Please enter the xml code:\n-------------------------------------")
            local xml = io.read()
            print("-------------------------------------")

            for argument in string.gmatch(xml, "aria[-]label=\"([^\"]+)\"") do -- For Username and Status
                info.username, info.status = string.match(argument, "([^,]+), (.+)")
            end
            for argument in string.gmatch(xml, "<img src=\"([^\"]+)\"") do -- For profile pic
                info.profilepic = argument
            end

            if info["username"] == false then 
                print("//505//: Couldn't find the username :(")
            elseif info["status"] == false then 
                print("//505//: Couldn't find the status :(")
            elseif info["profilepic"] == false then 
                print("//505//: Couldn't find the profile picture :(")
            end
        end
        
        local argumentCounter = 0
        if args ~= nil then argumentCounter = #args end
        
        if argumentCounter > 1 then 
            print ("//505//: No more than one argument is allowed for this command.")
        
        elseif argumentCounter == 0 then -- if no argument is given
            XmlParser()
            print("Username:           " .. info.username .. "\nStatus:             " .. info.status .. "\nProfile picture:    " .. info.profilepic.. "\n-------------------------------------")
        elseif info[string.lower(args[1])] ~= nil then -- if an existing and correct argument is given
            XmlParser()
            print(info[string.lower(args[1])])
        else 
            print("//404//: \"" .. args[1] .. "\" is not a valid argument.")
        end
    end,
    robloxid = function (args) -- Used for parsing Discord ids and orginazing the templates
        local Song = { -- Song info
            Name = false, 
            URL = false,
            ID = false
        }
        
        local function IdGetterPrinter() -- For getting the ID and printing resualts
            for argument in string.gmatch(Song.URL, "[^/]+") do -- Find the id
                if tonumber(argument) ~= nil then 
                    Song.ID = argument
                end
            end
            
            print("Please enter the song's name:\n-------------------------------------") -- Get the Song's name
            local Song_Name = io.read()
            Song.Name = Song_Name
            print("-------------------------------------")
            
            print("Name: `" .. Song.Name .. "`\nRoblox: `" .. Song.URL .. "`\nId: `" .. Song.ID .. "`\n**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~**")
        end
        
        local argumentCounter = 0
        if args ~= nil then argumentCounter = #args end
        
        if argumentCounter > 1 then 
            print ("//505//: No more than one argument is allowed for this command.")
        
        elseif argumentCounter == 0 then -- if no argument is given
            print("Please enter the song's URL on roblox:\n-------------------------------------")
            local Song_URL = io.read()
            Song.URL = Song_URL
            print("-------------------------------------") 
            IdGetterPrinter()
        --[[
        elseif string.match(args[1], "https://www.roblox.com/library/") then -- if a correct URL is given
            Song.URL = args[1]
            IdGetterPrinter()
        else 
            print("//404//: \"" .. args[1] .. "\" is not a valid sound URL.")

        ]]        
        elseif args[1] ~= nil then 
            Song.URL = args[1]
            IdGetterPrinter()
        end
    end,
    hi = function ()
        print("Heyy!👋")
    end,
    lua = function (args)
        if args == nil then 
            os.execute('start lua')
            print("Lua launched successfully!") 
        else 
        
            local argumentCounter = 0
            argumentCounter = #args
            
            if argumentCounter > 1 then 
                print ("//505//: No more than one argument is allowed for this command.")
            
            elseif string.find( args[1],"C:\\Users\\" .. Phx.Username .. "\\") ~= nil then -- if an existing and correct argument is given
                os.execute("start lua " .. args[1])
                print("Lua script started successfully!")
            else 
                print("//404//: \"" .. args[1] .. "\" is not a valid path.")
            end
        
        end 
    end,
    start = function (args)
        if args == nil then
            os.execute("start")
            print("cmd started successfully!")
        else
            local argumentCounter = #args
           
            if argumentCounter > 2 then 
                print ("//505//: No more than two arguments are allowed for this command.")
            elseif argumentCounter > 1 then
                os.execute("start " .. args[1] .. " " .. args[2])
                print(args[1] .. " started successfully!")
            else
                os.execute("start " .. args[1])
                print(args[1] .. " started successfully!")
            end
        end
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

if Phx.logo == true then
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
    print("|_____________________________________________________________________________|\n")
else 
    print("This is the unstable build PhxTest, current version: [" .. Phx.version .. "]\n")
end


--//io.read() loop
while true do -- Will loop until the program is stopped
    if CMDEntered ~= nil then 
        print("")
        CMDEntered = nil 
    end
    io.write("~* Phoneix/" .. Phx.Username .. ">") 
    local userInputOriginal = io.read() -- Gets the original Userinput 
    if userInputOriginal == "" then 
        local CMDEntered = nil
    else
        CMDEntered = true
    end
    
    local userInputList = {} -- the list of arugments 
    local userInputListCount = 0 -- count of userInputList
    
    for argument in string.gmatch(userInputOriginal, "[^%s]+") do -- Cuts the userinput into arugments and commands 
        table.insert(userInputList, argument) -- inserts them into userInputList
        userInputListCount = userInputListCount + 1 -- adds 1 to the count for each argument
    end
    
    if userInputListCount == 1 then -- if only a cmd is called in the userInput
        userInputList[1] = string.lower(userInputList[1])
        
        if commandsList[userInputList[1]] == nil then -- if that cmd doesnt doesnt exist
            print( "// 404 //: The command \"" .. userInputOriginal .. "\" either doesn't exist or is spelled wrong." )
        else -- execute that command
            commandsList[userInputList[1]]()
        end

    elseif userInputListCount > 1 then -- has the userInputed more than one argument?
        local command = userInputList[1]
        if commandsList[command] ~= nil then 
        table.remove(userInputList, 1) -- removes the cmd
        commandsList[command](userInputList)
        else
            print( "// 404 //: The command \"" .. userInputOriginal .. "\" either doesn't exist or is spelled wrong." )
        end
    end
end