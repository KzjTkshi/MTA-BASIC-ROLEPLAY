--[[

@project: bonecounty-rp.pl
@author: ohdude

]]

chat_range=7.5

function sprawdzZasieg(player,x,y,z,range)
    local px,py,pz=getElementPosition(player)
    return ((x-px)^2+(y-py)^2+(z-pz)^2)^0.5<=range
end

addEventHandler("onResourceStart", resourceRoot, function()
    local przedmioty = exports["bc_db"]:dbGet("SELECT * FROM przedmioty")
    for i, v in ipairs(przedmioty) do
        przedmiot = createElement("przedmiot")
        setElementData(przedmiot, "przedmiot", true)
        setElementData(przedmiot, "nazwa", tostring(v.nazwa).." ("..tostring(v.id)..")")
        setElementData(przedmiot, "idwlas", tonumber(v.wlasid))
        setElementData(przedmiot, "id", tostring(v.id))
        setElementData(przedmiot, "wlas1", tostring(v.wlas1))
        setElementData(przedmiot, "wlas2", tostring(v.wlas2))
        setElementData(przedmiot, "wlas3", tostring(v.wlas3))
    end

    local przedmioty_odlozone = exports["bc_db"]:dbGet("SELECT * FROM przedmioty_odlozone")
    for i, v in ipairs(przedmioty_odlozone) do
        local przedmiot_odlozony = createObject(1279, v.x, v.y, v.z-1)
        setElementData(przedmiot_odlozony, "odlozony_db", true)
        setElementData(przedmiot_odlozony, "obj:nazwa", tostring(v.nazwa).." ("..tostring(v.id)..")")
        setElementData(przedmiot_odlozony, "obj:nazwafix", tostring(v.nazwa))
        setElementData(przedmiot_odlozony, "obj:id", tostring(v.id))
        setElementData(przedmiot_odlozony, "obj:wlas1", tostring(v.wlas1))
        setElementData(przedmiot_odlozony, "obj:wlas2", tostring(v.wlas2))
        setElementData(przedmiot_odlozony, "obj:wlas3", tostring(v.wlas3))
    end
end)

addEvent("ustawSkina", true)
addEventHandler("ustawSkina", resourceRoot, function(przedmiot, plr)
    if getElementData(plr, "plr:ubranie:act") == false then
        local px,py,pz = getElementPosition(plr)
        local n = getPlayerName(plr)
        nickname = string.gsub(n,"_", " ")
        for _,v in ipairs(getElementsByType("player")) do
            if sprawdzZasieg(v,px,py,pz,chat_range) then
                outputChatBox("#dca2f4* "..nickname.." przebiera się.", v, r, g, b, true)
            end
        end
        setElementData(plr, "plr:ubranie:act", true)
        setElementModel(plr, tonumber(getElementData(przedmiot, "wlas2")))
    else
        setElementData(plr, "plr:ubranie:act", false)
        local px,py,pz = getElementPosition(plr)
        local n = getPlayerName(plr)
        nickname = string.gsub(n,"_", " ")
        for _,v in ipairs(getElementsByType("player")) do
            if sprawdzZasieg(v,px,py,pz,chat_range) then
                outputChatBox("#dca2f4* "..nickname.." przebiera się.", v, r, g, b, true)
            end
        end
        setElementModel(plr, tonumber(getElementData(plr, "plr:char_skin")))
    end
end)

addEvent("dajBron", true)
addEventHandler("dajBron", resourceRoot, function(przedmiot, plr)
    local px,py,pz = getElementPosition(plr)
    local n = getPlayerName(plr)
    nickname = string.gsub(n,"_", " ")
    if getElementData(przedmiot, "wlas3") == "de" then
        if getElementData(plr, "plr:eq:bron") == false then
            for _,v in ipairs(getElementsByType("player")) do
                if sprawdzZasieg(v,px,py,pz,chat_range) then
                    outputChatBox("#dca2f4* "..nickname.." wyciąga Desert Eagle", v, r, g, b, true)
                end
            end
            giveWeapon(plr, 24, tonumber(getElementData(przedmiot, "wlas2")), true)
            setElementData(plr, "plr:eq:bron", "de")
        else
            if getElementData(plr, "plr:eq:bron") ~= getElementData(przedmiot, "wlas3") then
                outputChatBox("Posiadasz już jakiś przedmiot w użyciu, schowaj go", plr, 255, 255, 255)
            end
            if getElementData(plr, "plr:eq:bron") == getElementData(przedmiot, "wlas3") then
                takeWeapon(plr, 24)
                for _,v in ipairs(getElementsByType("player")) do
                    if sprawdzZasieg(v,px,py,pz,chat_range) then
                        outputChatBox("#dca2f4* "..nickname.." chowa Desert Eagle", v, r, g, b, true)
                    end
                end
                setElementData(plr, "plr:eq:bron", false)
            end
        end
    end
    if getElementData(przedmiot, "wlas3") == "colt" then
        if getElementData(plr, "plr:eq:bron") == false then
            for _,v in ipairs(getElementsByType("player")) do
                if sprawdzZasieg(v,px,py,pz,chat_range) then
                    outputChatBox("#dca2f4* "..nickname.." wyciąga Colt", v, r, g, b, true)
                end
            end
            giveWeapon(plr, 22, tonumber(getElementData(przedmiot, "wlas2")), true)
            setElementData(plr, "plr:eq:bron", "colt")
        else
            if getElementData(plr, "plr:eq:bron") ~= getElementData(przedmiot, "wlas3") then
                outputChatBox("Posiadasz już jakiś przedmiot w użyciu, schowaj go", plr, 255, 255, 255)
            end
            if getElementData(plr, "plr:eq:bron") == getElementData(przedmiot, "wlas3") then
                takeWeapon(plr, 22)
                setElementData(plr, "plr:eq:bron", false)
                for _,v in ipairs(getElementsByType("player")) do
                    if sprawdzZasieg(v,px,py,pz,chat_range) then
                        outputChatBox("#dca2f4* "..nickname.." chowa Colt", v, r, g, b, true)
                    end
                end
            end
        end
    end
    if getElementData(przedmiot, "wlas3") == "ak" then
        if getElementData(plr, "plr:eq:bron") == false then
            for _,v in ipairs(getElementsByType("player")) do
                if sprawdzZasieg(v,px,py,pz,chat_range) then
                    outputChatBox("#dca2f4* "..nickname.." wyciąga AK-47", v, r, g, b, true)
                end
            end
            giveWeapon(plr, 30, tonumber(getElementData(przedmiot, "wlas2")), true)
            setElementData(plr, "plr:eq:bron", "ak")
        else
            if getElementData(plr, "plr:eq:bron") ~= getElementData(przedmiot, "wlas3") then
                outputChatBox("Posiadasz już jakiś przedmiot w użyciu, schowaj go", plr, 255, 255, 255)
            end
            if getElementData(plr, "plr:eq:bron") == getElementData(przedmiot, "wlas3") then
                takeWeapon(plr, 30)
                for _,v in ipairs(getElementsByType("player")) do
                    if sprawdzZasieg(v,px,py,pz,chat_range) then
                        outputChatBox("#dca2f4* "..nickname.." chowa AK-47", v, r, g, b, true)
                    end
                end
                setElementData(plr, "plr:eq:bron", false)
            end
        end
    end
end)

--1279

addEvent("odlozBron", true)
addEventHandler("odlozBron", resourceRoot, function(przedmiot, plr)
    local px,py,pz = getElementPosition(plr)
    local n = getPlayerName(plr)
    nickname = string.gsub(n,"_", " ")
    if getElementData(plr, "plr:eq:bron") == getElementData(przedmiot, "wlas3") then
        outputChatBox("Schowaj ten przedmiot zanim go odlozysz", plr, 255, 255, 255)
    else
        for _,v in ipairs(getElementsByType("player")) do
            if sprawdzZasieg(v,px,py,pz,chat_range) then
                outputChatBox("#dca2f4* "..nickname.." odkłada przedmiot.", v, r, g, b, true)
            end
        end

        local x, y, z = getElementPosition(plr)

        local obj = createObject(1279, x, y, z-1)
        setElementData(obj, "odlozony_db", true)
        setElementData(obj, "obj:nazwa", getElementData(przedmiot, "nazwa"))
        setElementData(obj, "obj:id", getElementData(przedmiot, "id"))
        setElementData(obj, "obj:wlas1", getElementData(przedmiot, "wlas1"))
        setElementData(obj, "obj:wlas2", getElementData(przedmiot, "wlas2"))
        setElementData(obj, "obj:wlas3", getElementData(przedmiot, "wlas3"))
        setElementData(obj, "obj:nazwa", tostring(getElementData(przedmiot, "nazwa")))

        local nazwa = getElementData(przedmiot, "nazwa")
        local tasak = split(nazwa, "(")
        local przekrojone = tasak[1]
        local poprawnaNazwa = string.sub(przekrojone, 1, -2)

        exports["bc_db"]:dbGet("DELETE FROM przedmioty WHERE id=?", tonumber(getElementData(przedmiot, "id")))
        exports["bc_db"]:dbSet("INSERT INTO przedmioty_odlozone (id, nazwa, wlas1, wlas2, wlas3, x, y, z) VALUES (?,?,?,?,?,?,?,?)", tonumber(getElementData(przedmiot, "id")), poprawnaNazwa, getElementData(przedmiot, "wlas1"), getElementData(przedmiot, "wlas2"), getElementData(przedmiot, "wlas3"), x, y, z)
        destroyElement(przedmiot)
    end
end)

addEvent("podniesPrzedmiotDB", true)
addEventHandler("podniesPrzedmiotDB", resourceRoot, function(przedmiot_z_ziemi, char_uid, uid, nazwa, wlas1, wlas2, wlas3, plr)
    local odlozonyPrzedmioty = getElementsByType("object")
    for i, v in ipairs(odlozonyPrzedmioty) do
        if getElementData(v, "odlozony_db") == true then
            if getElementData(v, "obj:nazwa") == przedmiot_z_ziemi then
                exports["bc_db"]:dbGet("DELETE FROM przedmioty_odlozone WHERE id=?", tonumber(uid))
                local ostatnialitera = string.sub(nazwa, -1)
                if ostatnialitera == ")" then
                    local tasak = split(nazwa, "(")
                    local naz = tasak[1]
                    nazwafix = string.sub(naz, 1, -2)
                end
                exports["bc_db"]:dbSet("INSERT INTO przedmioty (id, nazwa, wlasid, wlas1, wlas2, wlas3) VALUES (?,?,?,?,?,?)", tonumber(uid), nazwafix, tonumber(char_uid), tostring(wlas1), tonumber(wlas2), tostring(wlas3))
                local przedmiot2 = createElement("przedmiot")
                setElementData(przedmiot2, "przedmiot", true)
                setElementData(przedmiot2, "nazwa", nazwa)
                setElementData(przedmiot2, "idwlas", tonumber(char_uid))
                setElementData(przedmiot2, "id", tonumber(uid))
                setElementData(przedmiot2, "wlas1", tostring(wlas1))
                setElementData(przedmiot2, "wlas2", tostring(wlas2))
                setElementData(przedmiot2, "wlas3", tostring(wlas3))

                local px,py,pz = getElementPosition(plr)
                local n = getPlayerName(plr)
                nickname = string.gsub(n,"_", " ")
                for _,v in ipairs(getElementsByType("player")) do
                    if sprawdzZasieg(v,px,py,pz,chat_range) then
                        outputChatBox("#dca2f4* "..nickname.." podnosi przedmiot z ziemi.", v, r, g, b, true)
                    end
                end
                destroyElement(v)
            end
        end
    end
end)

addCommandHandler("podnies", function(plr, cmd)
    local x, y, z = getElementPosition(plr)
    local colC = createColSphere(x, y, z, 3)
    setTimer(function()
        destroyElement(colC)
    end, 1000, 1)
    local odlozonyPrzedmioty = getElementsByType("object")
    przedmiotyDoTriggera = {}
    for i, v in ipairs(odlozonyPrzedmioty) do
        if getElementData(v, "odlozony_db") == true then
            if isElementWithinColShape(v, colC) then
                table.insert(przedmiotyDoTriggera, v)
            end
        end
    end
    triggerClientEvent(plr, "podnoszenieGui", resourceRoot, przedmiotyDoTriggera)
end)