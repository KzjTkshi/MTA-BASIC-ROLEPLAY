--[[

@project: bonecounty-rp.pl
@author: ohdude

]]

addCommandHandler("rc", function(plr, cmd)
    redirectPlayer(plr, "51.83.172.144", 20228)
end)

addCommandHandler("qs", function(plr, cmd)
    kickPlayer(plr)
end)

addCommandHandler("q", function(plr, cmd)
    kickPlayer(plr)
end)

addEvent("przeladujBron", true)
addEventHandler("przeladujBron", resourceRoot, function(plr)
    reloadPedWeapon(plr)
end)

addCommandHandler("afk", function(plr, cmd, target)
    if not getElementData(plr, "plr:afk") then
        for _,v in ipairs(getElementsByType("player")) do
            if getElementData(v, "id") == tonumber(target) then
                if getElementData(v, "plr:zmini") == true then
                    triggerClientEvent(v, "unAFKPing", resourceRoot)
                else
                    return
                end
            end
        end
    else
        return
    end
end)

addEventHandler("onResourceStart", resourceRoot, function()
    checkTimer = setTimer(function()
		for _,v in ipairs(getElementsByType("player")) do
			local idle = getPlayerIdleTime(v)
			if tonumber(idle) >= 1 * 60 * 1000  then
				if getElementData(v, "plr:afk") == false then
                    setElementData(v, "plr:afk", true)
				end
			else
				if getElementData(v, "plr:afk") == true then
                    setElementData(v, "plr:afk", false)
				end
			end
		end
	end, 1000 ,0)
end)