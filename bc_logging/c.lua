--[[

@project: bonecounty-rp.pl
@author: ohdude

]]

cel = getPlayerName(localPlayer)

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), function()
    local screenW, screenH = guiGetScreenSize()
    box = guiCreateWindow((screenW - 393) / 2, (screenH - 244) / 2, 393, 244, "Logowanie", false)
    guiWindowSetSizable(box, false)
    
    zaloguj = guiCreateButton(132, 133, 130, 42, "Zaloguj", false, box)
    addEventHandler("onClientGUIClick", zaloguj, outputEditBox, false)

    rejestruj = guiCreateButton(132, 185, 130, 42, "Rejestracja", false, box)
    addEventHandler("onClientGUIClick", rejestruj, outputEditBox2, false)

    guiSetProperty(zaloguj, "NormalTextColour", "FFAAAAAA")
    login = guiCreateEdit(133, 32, 129, 38, "", false, box)
    pass = guiCreateEdit(133, 85, 129, 38, "", false, box)
    guiEditSetMasked(pass, true)
    guiSetInputMode("no_binds_when_editing")
    for i = 1,30 do
        outputChatBox(" ")
    end
    showChat(true)

    guiSetVisible(box, true)
    guiSetVisible(zaloguj, true)
    guiSetVisible(login, true)
    guiSetVisible(pass, true)
    guiWindowSetMovable(box, false)
    showCursor(true)
end)

addEvent("schowajGui", true)
addEventHandler("schowajGui", resourceRoot, function()
    guiSetVisible(box, false)
    guiSetVisible(zaloguj, false)
    guiSetVisible(login, false)
    guiSetVisible(pass, false)
    showCursor(false)
    showChat(true)
end)

function outputEditBox(button)
    if button == "left" then
        local passget = guiGetText(pass)
        local pass = string.lower(md5(tostring(passget)))
        local login = guiGetText(login)
        triggerServerEvent("sprawdzLogowanie", resourceRoot, login, pass, cel)
    end
end

function outputEditBox2(button)
    if button == "left" then
        local passget = string.lower(guiGetText(pass))
        local pass = string.lower(md5(tostring(passget)))
        local login = guiGetText(login)
        triggerServerEvent("rejestrujMnie", resourceRoot, login, pass, cel, passget)
    end
end

addEvent("podajWynik", true)
addEventHandler("podajWynik", resourceRoot, function(wynik)
    local screenW, screenH = guiGetScreenSize()
    box = guiCreateWindow((screenW - 249) / 2, (screenH - 343) / 2, 249, 343, "Wybór postaci", false)
    guiWindowSetSizable(box, false)

    postac = guiCreateButton(10, 302, 230, 15, "Stwórz nową postać", false, box)

    girdlista = guiCreateGridList(9, 23, 231, 276, false, box)
    guiGridListAddColumn(girdlista, "", 0.9)

    graj = guiCreateButton(11, 319, 229, 14, "Graj", false, box)
    addEventHandler("onClientGUIClick", graj, wyborPostaci, false)

    showCursor(true)  
    
    for i, v in ipairs(wynik) do   
        guiGridListAddRow(girdlista, string.gsub(tostring(v.nickname), "_", " "))
        skin = tonumber(v.skin)
        imie = tostring(v.imie)
        nazwisko = tostring(v.nazwisko)
    end
end)

function wyborPostaci()
    wynik = guiGridListGetItemText(girdlista, guiGridListGetSelectedItem(girdlista), 1)
    if wynik == "" then
        outputChatBox("Musisz wybrać postać", 255, 255, 255)
    else
        guiSetVisible(graj, false)
        guiSetVisible(girdlista, false)
        showCursor(false)
        local nickname = string.gsub(tostring(wynik), " ", "_")
        local nickgoscia = getPlayerName(localPlayer)
        guiSetVisible(box, false)
        triggerServerEvent("zrespGracza", resourceRoot, nickname, nickgoscia)
    end
end