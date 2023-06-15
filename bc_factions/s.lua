--[[

@author: ohdude, KusseK
@project: bonecounty-rp.pl

]]

local pojazdy = {
{598, -225.65, 990.89, 19.72-0.5},
{598, -225.64, 994.67, 19.26},
{599, -225.81, 998.64, 19.78}
}


for k,v in ipairs(pojazdy) do
    local radiola = createVehicle(v[1], v[2], v[3], v[4], 0, 0, -90)
    setElementData(radiola, "veh:data", "SD")
    setElementFrozen(radiola, true)
    setVehicleColor(radiola, 0, 72, 29, 255, 255, 255)
end

addEventHandler("onVehicleStartEnter", root, function(plr)
    if getElementData(source, "veh:data", true) == "SD" then
        if getElementData(plr, "plr:char_duty") == false then
            cancelEvent()
        end
    end
end)

function rozpocznijSluzbeFunc(he, md)
    local uid = getElementData(he, "plr:char_uid")
    local query = exports["bc_db"]:dbGet("SELECT * FROM factions WHERE idgracz=?", uid)
    if query and #query > 0 then
        if getElementData(he, "plr:char_duty") == "SD" then
            setElementData(he, "plr:char_duty", false)
            outputChatBox("Kończysz słuzbę", he, 255, 255, 255)
            setElementModel(he, getElementData(he, "plr:save_skin"))
            takeWeapon(he, 24)
            takeWeapon(he, 3)
            takeWeapon(he, 25)  
        else
            setElementData(he, "plr:char_duty", "SD")
            setElementData(he, "plr:save_skin", getElementModel(he))
            outputChatBox("Rozpoczynasz służbe", he, 255, 255, 255)
        end
    end
end

rozpocznij_sluzbe = createPickup(324.55, 309.25, 999.15-0.1, 3, 1247, 1)
setElementInterior(rozpocznij_sluzbe, 5)
addEventHandler("onPickupHit", rozpocznij_sluzbe, rozpocznijSluzbeFunc, false)

local t = createElement("text")
setElementInterior(t, 5)
setElementPosition(t, 324.55, 309.25, 999.15-0.1)
setElementData(t,"name","Rozpocznij służbę")


function wezSkinaFunc(he)
    if getElementData(he, "plr:char_duty", false) == "SD" then
        setElementModel(he, 283)
        giveWeapon(he, 24, 90, true)
        giveWeapon(he, 25, 24, false)
        giveWeapon(he, 3, 1, false)
    else
        outputChatBox("Nie jestes na służbie!", he, 255, 255, 255)
        takeWeapon(he, 24)
        takeWeapon(he, 3)
        takeWeapon(he, 25)
    end
end

wezSkina = createPickup (326.73, 307.26, 999.15, 3, 1275, 1)
setElementInterior(wezSkina, 5)
addEventHandler("onPickupHit", wezSkina, wezSkinaFunc, false)

function wezSkinaFunc(he)
    if getElementData(he, "plr:char_duty", false) == "SD" then 
        setElementModel(he, 282)
        giveWeapon(he, 24, 90, true)
        giveWeapon(he, 3, 1, false)
    else
        outputChatBox("Nie jestes na służbie!", he, 255, 255, 255)
        takeWeapon(he, 24)
        takeWeapon(he, 3)
    end
end

wezSkina = createPickup (326.80, 303.49, 999.15, 3, 1275, 1)
setElementInterior(wezSkina, 5)
addEventHandler("onPickupHit", wezSkina, wezSkinaFunc, false)

local t = createElement("text")
setElementInterior(t, 5)
setElementPosition(t, 326.80, 303.49, 999.15-0.1)
setElementData(t,"name","Cadet")

local t = createElement("text")
setElementInterior(t, 5)
setElementPosition(t, 326.73, 307.26, 999.15-0.1)
setElementData(t,"name","Sherif Officer")
