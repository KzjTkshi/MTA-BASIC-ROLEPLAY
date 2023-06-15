--[[

@project: bonecounty-rp.pl
@author: ohdude

]]

megafon_range=80
chat_range=7.5
krzyk_range=14
szept_range=2
sproboj_range=10

function sprawdzZasieg(player,x,y,z,range)
    local px,py,pz=getElementPosition(player)
    return ((x-px)^2+(y-py)^2+(z-pz)^2)^0.5<=range
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

addEventHandler("onPlayerChat", root, function(msg, msgType)
    if msgType == 0 then
        cancelEvent()
        local px,py,pz = getElementPosition(source)
        local nick1 = getPlayerName(source)
        local ostatnialitera = string.sub(msg, -1)
        local nick = string.gsub(nick1,"_", " ")
        local text = nick.." mówi: "..firstToUpper(msg)
        for _,v in ipairs(getElementsByType("player")) do
          if sprawdzZasieg(v,px,py,pz,chat_range) then
            if ostatnialitera == "!" or ostatnialitera == "." then
                outputChatBox(text, v, 255, 255, 255)
                outputServerLog(text, v, 255, 255, 255)
            else
                outputChatBox(text..".", v, 255, 255, 255)
                outputServerLog(text..".", v, 255, 255, 255)
            end
        end
      end
    end
end)

addEventHandler("onPlayerChat", root, function(msg, msgType)
    if msgType == 1 then
        cancelEvent()
        local px,py,pz = getElementPosition(source)
        local nick1 = getPlayerName(source)
        local nick = string.gsub(nick1,"_", " " )
        for _,v in ipairs(getElementsByType("player")) do
          if sprawdzZasieg(v,px,py,pz,chat_range) then
            outputChatBox("#dca2f4** "..nick.." "..msg, v, r, g, b, true)
            outputServerLog("#dca2f4** "..nick.." "..msg, v, r, g, b, true)
        end
      end
    end
end)

addCommandHandler("k", function(plr, cmd, ...)
local px,py,pz = getElementPosition(plr)
local nick1 = getPlayerName(plr)
local nick = string.gsub(nick1,"_", " " )
local text=table.concat({...}, " ")
    for _,v in ipairs(getElementsByType("player")) do
        if sprawdzZasieg(v,px,py,pz,krzyk_range) then
            outputChatBox(nick.." krzyczy: "..firstToUpper(text).."!", v, 255, 255, 255)
            outputServerLog(nick.." krzyczy: "..firstToUpper(text).."!", v, 255, 255, 255)
        end
    end
end)

addCommandHandler("m", function(plr, cmd, ...)
    local px,py,pz = getElementPosition(plr)
    local nick1 = getPlayerName(plr)
    local nick = string.gsub(nick1,"_", " " )
    local text=table.concat({...}, " ")
        for _,v in ipairs(getElementsByType("player")) do
            if sprawdzZasieg(v,px,py,pz,megafon_range) then
                if getElementData(plr, "plr:duty") == "SD" then   
                    outputChatBox(nick.."(MEGAFON):  "..firstToUpper(text).."!", v, 255, 185, 77)
                    outputServerLog(nick.."(MEGAFON):  "..firstToUpper(text).."!", v, 255, 185, 77)
                else   
                    return
                end
            end
        end
    end)

addCommandHandler("do", function(plr, cmd, ...)
local px,py,pz = getElementPosition(plr)
local nick1 = getPlayerName(plr)
local nick = string.gsub(nick1,"_", " " )
local text=table.concat({...}, " ")
    for _,v in ipairs(getElementsByType("player")) do
        if sprawdzZasieg(v,px,py,pz,chat_range) then
            outputChatBox("#67829b** "..text.." (( "..nick.." )) **", v, r, g, b, true)
            outputServerLog("#67829b** "..text.." (( "..nick.." )) **", v, r, g, b, true)
        end
    end
end)

addCommandHandler("b", function(plr, cmd, ...)
local px,py,pz = getElementPosition(plr)
local nick1 = getPlayerName(plr)
local nick = string.gsub(nick1,"_", " " )
local text=table.concat({...}, " ")
    for _,v in ipairs(getElementsByType("player")) do
        if sprawdzZasieg(v,px,py,pz,chat_range) then
            outputChatBox("(( OOC "..nick..": "..text.." ))", v, 169, 169, 169, true)
            outputServerLog("(( OOC "..nick..": "..text.." ))", v, 169, 169, 169, true)
        end
    end
end)

addCommandHandler("w", function(plr, cmd, target, ...)
    local nick1 = getPlayerName(plr)
    local nick = string.gsub(nick1, "_", " ")
    local text=table.concat({...}, " ")
    if target == nil then
        --outputChatBox("Podaj poprawne ID", plr, 255, 255, 255)
    else
        for _,v in ipairs(getElementsByType("player")) do
            if getElementData(v, "id") == tonumber(target) then
                outputChatBox("(( PW > "..string.gsub(getPlayerName(v), "_", " ")..": "..text.." ))", plr, 255, 171, 0)
                outputChatBox("(( PW < "..nick..": "..text.." ))", v, 255, 171, 0)
                outputServerLog("(( PW > "..string.gsub(getPlayerName(v), "_", " ")..": "..text.." ))", plr, 255, 171, 0)
                outputServerLog("(( PW < "..nick..": "..text.." ))", v, 255, 171, 0)
            end
        end
    end
end)

addCommandHandler("c", function(plr, cmd, ...)
    local px,py,pz = getElementPosition(plr)
    local nick1 = getPlayerName(plr)
    local nick = string.gsub(nick1,"_", " " )
    local text=table.concat({...}, " ")
    for _,v in ipairs(getElementsByType("player")) do
        if sprawdzZasieg(v,px,py,pz,szept_range) then
            outputChatBox(nick.." szepcze: "..firstToUpper(text)..".", v, 255, 255, 255)
            outputServerLog(nick.." szepcze: "..firstToUpper(text)..".", v, 255, 255, 255)
        end
    end
end)

local losujLiczbe = math.random(10, 50)

addCommandHandler("sprobuj", function(plr, cmd, ...)
    local losujLiczbe = math.random(10, 50)
    local px,py,pz = getElementPosition(plr)
    local nick1 = getPlayerName(plr)
    local nick = string.gsub(nick1,"_", " " )
    local text=table.concat({...}, " ")
    local ostatnialitera = string.sub(text, -1)
    for _,v in ipairs(getElementsByType("player")) do
        if sprawdzZasieg(v,px,py,pz,sproboj_range) then
            if (losujLiczbe < 25) then
                if ostatnialitera == "!" or ostatnialitera == "." then
                    outputChatBox("* "..nick.." odniósł sukces próbując "..text, v, 220, 162, 244)
                else
                    outputChatBox("* "..nick.." odniósł sukces próbując "..text..".", v, 220, 162, 244)
                end      
            else
                if ostatnialitera == "!" or ostatnialitera == "." then
                    outputChatBox("* "..nick.." zawiódł próbując "..text, v, 220, 162, 244)
                else
                    outputChatBox("* "..nick.." zawiódł próbując "..text..".", v, 220, 162, 244)
                end
            end
        end   
    end
end)

       