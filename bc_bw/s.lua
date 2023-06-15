--[[

@project: bonecounty-rp.pl
@author: ohdude

]]

addEvent("zrespPoBW", true)
addEventHandler("zrespPoBW", resourceRoot, function(x, y, z, skin, plr)
    spawnPlayer(plr, x, y, z, 0, skin)
    setCameraTarget(plr, plr)
    triggerClientEvent(plr, "usunHandlera", resourceRoot)
    setPlayerHudComponentVisible(plr, "all", true)
    setPlayerHudComponentVisible(plr, "clock", false)
    showChat(plr, true)
end)