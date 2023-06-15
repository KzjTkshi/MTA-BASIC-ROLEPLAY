--[[

@project: bonecounty-rp.pl
@author: ohdude

]]

local blipy = {
    {-222.56, 978.96, 28.26, 30}, -- sd
    {-207.88, 1119.19, 20.43, 39}, -- urzad
    {172.55, 1176.70, 14.76, 14} -- cluckin
}

for k,v in ipairs(blipy) do
    createBlip(v[1], v[2], v[3], v[4], 1, r, g, b, 255, 0, 150)
end

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), function()
    setMapName("RP")
    setGameType("RP")
    setGameSpeed(1)
    outputDebugString("CORE: bonecounty-rp.pl (✓)")
end)

addEventHandler("onPlayerChangeNick", root, function(on, nn, cbu)
    if cbu then
        cancelEvent()
    end
end)

addEventHandler("onPlayerCommand", root, function(cmd)
    if cmd == "nick" then
        cancelEvent()
    end
end)

addEventHandler("onPlayerJoin", root, function()
end)