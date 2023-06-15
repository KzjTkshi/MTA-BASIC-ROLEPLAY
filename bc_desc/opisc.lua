--[[

@project: bonecounty-rp.pl
@author: ohdude

]]

opis = 0
addCommandHandler("opis", function(plr, cmd)
    if opis == 0 then
        opis = 1

        local screenW, screenH = guiGetScreenSize()
        box = guiCreateWindow((screenW - 300) / 2, (screenH - 198) / 2, 300, 198, "Opis", false)
        guiWindowSetSizable(box, false)

        btn = guiCreateButton(50, 152, 199, 17, "Ustaw opis", false, box)
        addEventHandler("onClientGUIClick", btn, ustawGracz, false)

        btn2 = guiCreateButton(50, 172, 199, 17, "Ustaw w pojezdzie", false, box)
        addEventHandler("onClientGUIClick", btn2, ustawPojazd, false)

        memo = guiCreateMemo(0, 25, 289, 123, "", false, box)
        guiSetInputMode("no_binds_when_editing")

        cel = getPlayerName(localPlayer)
        
        guiSetVisible(box, true)
        showCursor(true)
    else
        opis = 0
        guiSetVisible(box, false)
        showCursor(false)
    end
end)

function ustawGracz(button)
    local pobranyopis = tostring(guiGetText(memo))
    if string.len(pobranyopis) <= 50 then
        if button == "left" then
            setElementData(getPlayerFromName(cel), "desc", pobranyopis)
            opis = 0
            guiSetVisible(box, false)
            showCursor(false)
        end
    else
        outputChatBox("Opis jest za długi", 255, 255, 255)
    end
end

function ustawPojazd(button)
    if button == "left" then
        local pobranyopis = tostring(guiGetText(memo))
        setElementData(getPlayerFromName(cel), "veh:desc", pobranyopis)
        opis = 0
        guiSetVisible(box, false)
        showCursor(false)
    end
end     