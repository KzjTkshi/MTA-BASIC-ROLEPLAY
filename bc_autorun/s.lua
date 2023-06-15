--[[

@project: bonecounty-rp.pl
@author: ohdude

]]

addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), function()
    for k,v in ipairs(getResources()) do
	    if string.find(getResourceName(v), "bc") or string.find(getResourceName(v), "community") then
            stopResource(v)
	    end
    end
end)

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), function()
    for k,v in ipairs(getResources()) do
        if string.find(getResourceName(v), "bc") or string.find(getResourceName(v), "community") then
            startResource(v)
        end
    end
end)