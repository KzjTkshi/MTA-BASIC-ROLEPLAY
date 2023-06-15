--[[

@project: bonecounty-rp.pl
@author: z SanCity + ohdude

]]
local sx,sy=guiGetScreenSize()

function renderSmierc()
	dxDrawRectangle(0, 0, sx, sy, tocolor(255, 0, 0, 185), false)
end

addEvent("usunHandlera", true)
addEventHandler("usunHandlera", resourceRoot, function()
	removeEventHandler("onClientRender", root, renderSmierc)
end)

rot = 360
function moveCameraToCreation()
	local pX, pY, pZ = getElementPosition(localPlayer)
	local x = pX + math.cos(math.deg(rot))*2
	local y = pY + math.sin(math.deg(rot))*2
		
	local sight, eX, eY, eZ = processLineOfSight(pX, pY, pZ, x, y, pZ+1, true, true, false)
			
	if (sight) then
		setCameraMatrix(eX, eY, eZ, pX, pY, pZ+6)
	else
		setCameraMatrix(x, y, pZ+8, pX, pY, pZ+1)
	end
	rot = rot + 0.0001
end

addEventHandler("onClientPlayerWasted", localPlayer, function()
	addEventHandler("onClientRender", root, renderSmierc)
	moveCameraToCreation()
	--g_MissionTimer = exports.missiontimer:createMissionTimer(300000, true, "%m:%s", 0.5,20, bg, font, scale, r, g, b )
end)

function zrespGracz(plr)
    setPlayerHudComponentVisible("all", true)
    setPlayerHudComponentVisible("clock", false)
    showChat(true)
	local x, y, z = getElementPosition(plr)
	setElementData(plr, "plr:bw_ame", false)
    local skin = getElementModel(plr)
    fadeCamera(true)
    triggerServerEvent("zrespPoBW", resourceRoot, x, y, z, skin, plr)
	setElementData(plr, "plr:bw", false)
	--usunHandlera()
	if isTimer(odliczanieDoZrespienia) then
		killTimer(odliczanieDoZrespienia)
		destroyElement(licznik)
	else
		destroyElement(licznik)
		return
	end
end

addEventHandler("onClientPlayerWasted", localPlayer, function()
    setPlayerHudComponentVisible("all", false)
    showChat(false)
    x, y, z = getElementPosition(source)
	odliczanieDoZrespienia = setTimer(zrespGracz, 30000, 1, source)
	setElementData(source, "plr:bw", true)
	setElementData(source, "plr:bw_ame", "*"..getPlayerName(source).." jest nieprzytomny.")
	licznik = exports.missiontimer:createMissionTimer(300000, true, "%m:%s", 0.5, 0.20, true, "default-bold", 1, 255, 0, 0)
end)

addEventHandler("onClientPlayerQuit", root, function()
	if isTimer(odliczanieDoZrespienia) then
		killTimer(odliczanieDoZrespienia)
	else
		return
	end
end)