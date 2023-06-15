--[[

@project: angelpine-rp.pl
@author: ohdude

]]

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), function()
    setPlayerHudComponentVisible(root, "clock", false)
end)

addEventHandler("onPlayerJoin", root, function()
    setPlayerHudComponentVisible(source, "clock", false)
end)