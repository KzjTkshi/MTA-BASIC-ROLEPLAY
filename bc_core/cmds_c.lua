--[[

@project: bonecounty-rp.pl
@author: ohdude, KusseK

]]

bindKey("r", "down", function()
    triggerServerEvent("przeladujBron", resourceRoot, localPlayer)
end)

stats = 0
addCommandHandler("stats", function()
    if getElementData(localPlayer, "plr:logged") == true then
        if stats == 0 then
            stats = 1
            local screenW, screenH = guiGetScreenSize()
            gui_win = guiCreateWindow((screenW - 355) / 2, (screenH - 200) / 2, 355, 200, "Statystyki", false)
            guiWindowSetSizable(gui_win, false)

            gridlista = guiCreateGridList(10, 26, 330, 165, false, gui_win)
            guiGridListAddColumn(gridlista, "Statystyka", 0.5)
            guiGridListAddColumn(gridlista, "Wartość", 0.45)
            for i = 1, 8 do
                guiGridListAddRow(gridlista)
            end
            guiGridListSetItemText(gridlista, 0, 1, "Czas gry", false, false)
            guiGridListSetItemText(gridlista, 0, 2, tostring(getElementData(localPlayer, "plr:char_minuty")).."min", false, false)
            guiGridListSetItemText(gridlista, 1, 1, "Gotówka", false, false)
            guiGridListSetItemText(gridlista, 1, 2, "$"..tostring(getPlayerMoney(localPlayer)), false, false)
            guiGridListSetItemText(gridlista, 2, 1, "Stan konta", false, false)
            guiGridListSetItemText(gridlista, 2, 2, "$"..tostring(getElementData(localPlayer, "plr:char_stankonta")), false, false)
            guiGridListSetItemText(gridlista, 3, 1, "Wiek postaci", false, false)
            guiGridListSetItemText(gridlista, 3, 2, tostring(getElementData(localPlayer, "plr:char_wiek")).."lat", false, false)
            guiGridListSetItemText(gridlista, 4, 1, "Płeć", false, false)
            guiGridListSetItemText(gridlista, 4, 2, tostring(getElementData(localPlayer, "plr:char_plec")), false, false)
            guiGridListSetItemText(gridlista, 5, 1, "Skin", false, false)
            guiGridListSetItemText(gridlista, 5, 2, getElementModel(localPlayer), false, false)
            guiGridListSetItemText(gridlista, 6, 1, "Miejsce spawnu", false, false)
            guiGridListSetItemText(gridlista, 6, 2, "Fort Carson", false, false)
            guiGridListSetItemText(gridlista, 7, 1, "UID Postaci", false, false)
            guiGridListSetItemText(gridlista, 7, 2, tostring(getElementData(localPlayer, "plr:char_uid")), false, false)    
            guiSetVisible(gui_win, true)
            guiSetVisible(gridlista, true)    
        else
            stats = 0
            guiSetVisible(gui_win, false)
            guiSetVisible(gridlista, false)
        end
    else
        return
    end
end)

f1 = 0
function guiF1()
    if getElementData(localPlayer, "plr:logged") == true then
        if f1 == 0 then
        f1 = 1
        local screenW, screenH = guiGetScreenSize()
        showCursor(true)

        f1box = guiCreateWindow((screenW - 637) / 2, (screenH - 387) / 2, 637, 387, "Panel informacyjny", false)
        guiWindowSetSizable(f1box, false)

        f1tabpanel = guiCreateTabPanel(10, 25, 617, 352, false, f1box)

        f1tab1 = guiCreateTab("Jak zacząć", f1tabpanel)

        f1scroll1 = guiCreateScrollPane(0, 1, 617, 327, false, f1tab1)

        f1label1 = guiCreateLabel(32, 47, 460, 236, "jakis tam tekst ess??", false, f1scroll1)


        f1tab2 = guiCreateTab("Komendy", f1tabpanel)

        f1scroll2 = guiCreateScrollPane(5, 5, 608, 300, false, f1tab2)

        guiCreateLabel(50, 14, 599, 50, "/w - poprawne użycie /w [id] [treść] - prywatna wiadomość", false, f1scroll2)
        guiCreateLabel(50, 34, 605, 22, "/anims - spis animacji dostępnych na serwerze (F8)", false, f1scroll2)
        guiCreateLabel(50, 54, 605, 15, "/stats - statystyki postaci", false, f1scroll2)
        guiCreateLabel(50, 74, 595, 19, "/c - poprawne użycie /c [narracja] -  szept", false, f1scroll2)
        guiCreateLabel(50, 94, 599, 26, "/k - poprawne użycie /k [narracja] -  krzyk", false, f1scroll2)
        guiCreateLabel(50, 114, 601, 23, "/me - poprawne użycie /me [akcja] - opisuje czynność, którą wykonuje postać", false, f1scroll2)
        guiCreateLabel(50, 134, 603, 15, "/do - poprawne użycie /do [akcja] - służy do opisywania otoczenia, postaci", false, f1scroll2)
        guiCreateLabel(50, 154, 602, 15, "/b - poprawne użycie /b [treść] - chat OOC", false, f1scroll2)
        guiCreateLabel(50, 174, 607, 17, "/a - spis administracji online", false, f1scroll2)
        guiCreateLabel(50, 194, 605, 15, "/report - panel zgłoszenia", false, f1scroll2)


        f1tab3 = guiCreateTab("Informacje", f1tabpanel)

        f1scroll3 = guiCreateScrollPane(-1, 0, 618, 328, false, f1tab3)   

            guiSetVisible(f1box, true)
        else
            f1 = 0
            guiSetVisible(f1box, false)
            showCursor(false)
        end
    else
        return
    end
end
bindKey("F1", "down", guiF1)

local timer = getTickCount()
local minuta = 60
addEventHandler("onClientRender", root ,function()
	local tick = getTickCount()
    if tick - timer >= minuta*1000 then
        if getElementData(localPlayer, "plr:logged") == true then
            if getElementData(localPlayer, "plr:afk") == false then
                timer = getTickCount()
                local m = tonumber(getElementData(localPlayer, "plr:char_minuty")) or 0
                setElementData(localPlayer, "plr:char_minuty", m+1)
            end
        else
            return
        end
	end
end)

addEvent("unAFKPing", true)
addEventHandler("unAFKPing", resourceRoot, function()
    setWindowFlashing(true, 10)
end)

addEventHandler("onClientMinimize", root, function()
    setElementData(localPlayer, "plr:afk", true)
    setElementData(localPlayer, "plr:zmini", true)
end)

addEventHandler("onClientRestore", root, function()
    setElementData(localPlayer, "plr:afk", false)
    setElementData(localPlayer, "plr:zmini", false)
end)

addCommandHandler("drawd", function(plr, cmd)
    setFarClipDistance(cmd, distance)
end)
