--[[

@project: bonecounty-rp.pl
@author: ohdude

]]

eqw = 0
screenW, screenH = guiGetScreenSize()

function pokazEkwipunek()
    if getElementData(localPlayer, "plr:logged") == true then
        if eqw == 0 then
            eqw = 1
            eq = guiCreateWindow((screenW - 263) / 2, (screenH - 303) / 2, 263, 310, "Ekwipunek", false)
            guiWindowSetSizable(eq, false)

            wyjmij = guiCreateButton(0, 260, 244, 16, "Użyj", false, eq)
            guiSetProperty(wyjmij, "NormalTextColour", "FFAAAAAA")
            addEventHandler("onClientGUIClick", wyjmij, pokazMenu, false)

            zamknij = guiCreateButton(0, 280, 244, 16, "Zamknij", false, eq)
            guiSetProperty(zamknij, "NormalTextColour", "FFAAAAAA")
            addEventHandler("onClientGUIClick", zamknij, zamknijGui, false)

            gridlist = guiCreateGridList(0, 28, 245, 226, false, eq)
            guiGridListAddColumn(gridlist, "Przedmioty", 0.85)

            local przedmiot = getElementsByType("przedmiot")
            if przedmiot then
                for _,v in ipairs(przedmiot) do
                    plrcharid = getElementData(localPlayer, "plr:char_uid")
                    if getElementData(v, "idwlas") == tonumber(plrcharid) then
                        guiGridListAddRow(gridlist, getElementData(v, "nazwa"))
                    end
                end
            end
            
            guiSetVisible(eq, true)
            guiSetVisible(wyjmij, true)
            guiSetVisible(zamknij, true)
            guiSetVisible(gridlist, true)
            showCursor(true)

            nick = getPlayerName(localPlayer)
        else
            eqw = 0
            guiSetVisible(eq, false)
            guiSetVisible(wyjmij, false)
            guiSetVisible(zamknij, false)
            guiSetVisible(gridlist, false)
            if winmenu then
                guiSetVisible(winmenu, false)
            end
            showCursor(false)
        end
    end
end

bindKey("i", "down", pokazEkwipunek)

addCommandHandler("p", function()
    pokazEkwipunek()
end)

function zamknijGui(button)
    if button == "left" then
        eqw = 0
        guiSetVisible(eq, false)
        guiSetVisible(wyjmij, false)
        guiSetVisible(zamknij, false)
        guiSetVisible(gridlist, false)
        if winmenu then
            guiSetVisible(winmenu, false)
        end
        showCursor(false)
    end
end

function pokazMenu()
        winmenu = guiCreateWindow((screenW - 247) / 2, (screenH - 98) / 2, 247, 98, "Panel interakcji z przedmiotem", false)
        guiWindowSetSizable(winmenu, false)

        btnuzyj = guiCreateButton(5, 30, 238, 17, "Użyj", false, winmenu)
        addEventHandler("onClientGUIClick", btnuzyj, uzyjPrzedmiot, false)

        btnodloz = guiCreateButton(5, 50, 238, 17, "Odłóż", false, winmenu)
        addEventHandler("onClientGUIClick", btnodloz, odlozPrzedmiot, false)

        btnzamknij = guiCreateButton(5, 70, 238, 17, "Zamknij", false, winmenu)
        addEventHandler("onClientGUIClick", btnzamknij, zamknijOkna, false)   
end

function zamknijOkna()
    guiSetVisible(winmenu, false)
end

function uzyjPrzedmiot()
    wynik = guiGridListGetItemText(gridlist, guiGridListGetSelectedItem(gridlist), 1)
    if wynik == "" then
    else
        local przedmioty = getElementsByType("przedmiot")
        for i,przedmiot in pairs(przedmioty) do
            if getElementData(przedmiot, "nazwa") == wynik then
                if getElementData(przedmiot, "wlas1") == "bron" then
                    if getElementData(przedmiot, "wlas3") == "de" then
                        triggerServerEvent("dajBron", resourceRoot, przedmiot, localPlayer)
                    end
                    if getElementData(przedmiot, "wlas3") == "colt" then
                        triggerServerEvent("dajBron", resourceRoot, przedmiot, localPlayer)
                    end
                    if getElementData(przedmiot, "wlas3") == "ak" then
                        triggerServerEvent("dajBron", resourceRoot, przedmiot, localPlayer)
                    end
                end
                if getElementData(przedmiot, "wlas1") == "inne" then
                    if getElementData(przedmiot, "wlas3") == "ubranie" then
                        triggerServerEvent("ustawSkina", resourceRoot, przedmiot, localPlayer)
                    end
                end
            end
        end
        eqw = 0
        guiSetVisible(eq, false)
        guiSetVisible(wyjmij, false)
        guiSetVisible(zamknij, false)
        guiSetVisible(gridlist, false)
        guiSetVisible(winmenu, false)
        showCursor(false)
    end
end

addEventHandler("onClientPlayerWeaponFire", root, function()
    if getPedTotalAmmo(source) == 0 then
        if getPedWeapon(source) == 22 then
            local brak_ammo = true
            triggerServerEvent("zabierzBron", root, nick, brak_ammo)
        end
    end
end)

function odlozPrzedmiot()
    wynik = guiGridListGetItemText(gridlist, guiGridListGetSelectedItem(gridlist), 1)
    if wynik == "" then
    else
        local przedmioty = getElementsByType("przedmiot")
        for i,przedmiot in pairs(przedmioty) do
            if getElementData(przedmiot, "nazwa") == wynik then
                triggerServerEvent("odlozBron", resourceRoot, przedmiot, localPlayer)
            end
        end
        eqw = 0
        guiSetVisible(eq, false)
        guiSetVisible(wyjmij, false)
        guiSetVisible(zamknij, false)
        guiSetVisible(gridlist, false)
        guiSetVisible(winmenu, false)
        showCursor(false)
    end
end

function zamknijGuiPodnoszenia()
    guiSetVisible(podnoszenie, false)
    showCursor(false)
end

function podniesPrzedmiot()
    przedmiot_z_ziemi = guiGridListGetItemText(przedmiotygrid, guiGridListGetSelectedItem(przedmiotygrid), 1)
    if przedmiot_z_ziemi == "" then
    else
        local selectedRow, selectedColumn = guiGridListGetSelectedItem(przedmiotygrid)
        local doPrzekazania = guiGridListGetItemData(przedmiotygrid, selectedRow, selectedColumn)

        local tasak = split(doPrzekazania, ",")
        local uid = tasak[1]
        local char_uid = getElementData(localPlayer, "plr:char_uid")
        local nazwa = tasak[2]
        local wlas1 = tasak[3]
        local wlas2 = tasak[4]
        local wlas3 = tasak[5]

        triggerServerEvent("podniesPrzedmiotDB", resourceRoot, przedmiot_z_ziemi, char_uid, uid, nazwa, wlas1, wlas2, wlas3, localPlayer)
    end
    guiSetVisible(podnoszenie, false)
    showCursor(false)
end

addEvent("podnoszenieGui", true)
addEventHandler("podnoszenieGui", resourceRoot, function(przedmiotyDoTriggera)
    podnoszenie = guiCreateWindow((screenW - 216) / 2, (screenH - 318) / 2, 216, 318, "Przedmioty w pobliżu", false)
    guiWindowSetSizable(podnoszenie, false)
    pbtnpodnies = guiCreateButton(5, 265, 200, 16, "Podnieś", false, podnoszenie)
    addEventHandler("onClientGUIClick", pbtnpodnies, podniesPrzedmiot, false)

    pbtnzamknij = guiCreateButton(5, 286, 200, 16, "Zamknij", false, podnoszenie)
    addEventHandler("onClientGUIClick", pbtnzamknij, zamknijGuiPodnoszenia, false)
    
    przedmiotygrid = guiCreateGridList(5, 20, 207, 241, false, podnoszenie)

    column = guiGridListAddColumn(przedmiotygrid, "Nazwa", 0.9)

    if przedmiotyDoTriggera then
        for _,v in ipairs(przedmiotyDoTriggera) do
            local row = guiGridListAddRow(przedmiotygrid)
            guiGridListSetItemText(przedmiotygrid, row, column, getElementData(v, "obj:nazwa"), false, false )
            local data = getElementData(v, "obj:id")..","..getElementData(v, "obj:nazwa")..","..tostring(getElementData(v, "obj:wlas1"))..","..tostring(getElementData(v, "obj:wlas2"))..","..tostring(getElementData(v, "obj:wlas3"))
            guiGridListSetItemData(przedmiotygrid, row, column, data)
        end
    end    

    guiSetVisible(podnoszenie, true)
    showCursor(true)
end)