--[[

@project: bonecounty-rp.pl
@author: ? edit ohdude

]]

tag = {};
strPlayers = {};

--return
tag.NAMETAG_OFFSET = 0.2;
tag.NAMETAG_WIDTH = 100;
tag.NAMETAG_HEIGHT = 70;
tag.NAMETAG_MAX_DISTANCE = 15;
tag.NAMETAG_MAX_DISTANCE2 = 10;
tag.NAMETAG_SCALE = 0;
tag.dxDraw = dxDrawText;

tag.dxCreateFont = dxCreateFont;
tag.nametagFont = tag
tag.size = 1;
tag.color = 240;
tag.size2 = "center"
tag.nametagsVisible = true

function wyswietlAmeBW()
	usunOpisBW = setTimer(function()
		setElementData(localPlayer, "plr:bw_ame", false)
	end, 300000, 1)
end

function wyswietlAme()
	usunOpis = setTimer(function()
		setElementData(localPlayer, "plr:char_ame", false)
	end, 3000, 1)
end

addEventHandler("onClientElementDataChange", root, function(theKey, oldValue, newValue)
	if getElementType(source) == "player" and theKey == "plr:char_ame" then
		wyswietlAme()
	end
end)

addEventHandler("onClientElementDataChange", root, function(theKey, oldValue, newValue)
	if getElementType(source) == "player" and theKey == "plr:bw_ame" then
		wyswietlAmeBW()
	end
end)

local function removeHexFromString(string)
	return string.gsub(string, "#%x%x%x%x%x%x","")
end


addEventHandler("onClientRender", root, function ()
	if not tag.nametagsVisible then
		return
	end
	--local r, g, b = exports.dpUI:getThemeColor()
	local cx, cy, cz = getCameraMatrix()
	for player, info in pairs(strPlayers) do
		local px, py, pz = getPedBonePosition(player, 6)
		local px2, py2, pz2 = getPedBonePosition(player, 2)				
		local x, y = getScreenFromWorldPosition(px, py, pz + tag.NAMETAG_OFFSET)
		local xx, yy = getScreenFromWorldPosition(px2, py2, pz2 + tag.NAMETAG_OFFSET)

		if xx then
			tag.distance = getDistanceBetweenPoints3D(cx, cy, cz, px, py, pz)
			tag.distance2 = getDistanceBetweenPoints3D(cx, cy, cz, px, py, pz)
			if tag.distance2 < tag.NAMETAG_MAX_DISTANCE2 then
				local opis = getElementData(player, "desc")
				local scale2 = 1 / tag.distance * tag.NAMETAG_SCALE
				local width2 = tag.NAMETAG_WIDTH * scale2
				local height2 = tag.NAMETAG_HEIGHT * scale2
				local nx2, ny2 = xx - width2 / 2, yy - height2 / 2

				if opis then
					tag.dxDraw(tostring(opis), nx2+1, ny2+1, nx2 + width2+1, ny2 + height2+1, tocolor(0,0,0, 255), tag.size,tag.size, "default-bold", tag.size2, tag.size2)
					tag.dxDraw(tostring(opis), nx2, ny2, nx2 + width2, ny2 + height2, tocolor(tag.color, tag.color, tag.color, tag.color), tag.size,tag.size, "default-bold", tag.size2, tag.size2)
				end
				
			end
		end

		if x then


			if tag.distance < tag.NAMETAG_MAX_DISTANCE then
				local name = info.name or 0
				local id = info.ids or 0
				--local famali = info.familia or "false"
				local obshe = name.." ("..id..")"
				local obsh = string.gsub(obshe,"_", " " )
				local shownametag = getElementData(player, "plr:nametagshow")
				local akcja = getElementData(player, "plr:char_ame")
				local bwAME = getElementData(player, "plr:bw_ame")
				local opis = getElementData(player, "desc")
				local scale = 1 / tag.distance * tag.NAMETAG_SCALE
				local width = tag.NAMETAG_WIDTH * scale
				local height = tag.NAMETAG_HEIGHT * scale
				local nx, ny = x - width / 2, y - height / 2
				
				if bwAME then
					tag.dxDraw(tostring(bwAME), nx+1, ny-7, nx + width-10, ny-10 + height-10, tocolor(0,0,0, 255), tag.size,tag.size, "default-bold", tag.size2, tag.size2)
					tag.dxDraw(tostring(bwAME), nx, ny-8, nx + width-10, ny-10 + height-10, tocolor(220, 162, 244), tag.size,tag.size, "default-bold", tag.size2, tag.size2)
				end

				if akcja then
					tag.dxDraw(tostring(akcja), nx+1, ny-7, nx + width-10, ny-10 + height-10, tocolor(0,0,0, 255), tag.size,tag.size, "default-bold", tag.size2, tag.size2)
					tag.dxDraw(tostring(akcja), nx, ny-8, nx + width-10, ny-10 + height-10, tocolor(220, 162, 244), tag.size,tag.size, "default-bold", tag.size2, tag.size2)
				end
			
				if shownametag == false then
					tag.dxDraw(tostring(obsh), nx+1, ny+1, nx + width+1, ny + height+1, tocolor(0,0,0, 255), tag.size,tag.size, "default-bold", tag.size2, tag.size2)
					tag.dxDraw(tostring(obsh), nx, ny, nx + width, ny + height, tocolor(tag.color, tag.color, tag.color, tag.color), tag.size,tag.size, "default-bold", tag.size2, tag.size2)
				end
			end
		end
	end
end)

function tag.showPlayer(player)
	if not isElement(player) then
		return false
	end
	setPlayerNametagShowing(player, false)
	strPlayers[player] = {name = player.name,ids = getElementData(player,"id") or 0}
	return true
end

addEventHandler("onClientElementStreamIn", root, function ()
	if source.type == "player" then
		tag.showPlayer(source)
	end
end)

addEventHandler("onClientElementStreamOut", root, function ()
	if source.type == "player" then
		strPlayers[source] = nil
	end
end)

addEventHandler("onClientPlayerQuit", root, function ()
	strPlayers[source] = nil
end)

addEventHandler("onClientPlayerJoin", root, function ()
	if isElementStreamedIn(source) then
		tag.showPlayer(source)
	end
	setPlayerNametagShowing(source, false)
end)

addEventHandler("onClientElementDataChange", root, function(key, ov, nv)
	if key == "plr:nametagshow" then
		setPlayerNametagShowing(source, nv)
    end
end)

addEventHandler("onClientPlayerSpawn", root, function ()
	if isElementStreamedIn(source) then
		tag.showPlayer(source)
	end
end)

addEventHandler("onClientResourceStart", resourceRoot, function ()
	for i, player in ipairs(getElementsByType("player")) do
		if isElementStreamedIn(player) then
			tag.showPlayer(player)
		end
		setPlayerNametagShowing(player, false)
	end

end)

function setVisible(visible)
	tag.nametagsVisible = not not visible
end

