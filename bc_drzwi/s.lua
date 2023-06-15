--[[

@project: bonecounty-rp.pl
@author: ohdude

]]


function zbindujKlawiszPowrot(he, md)
    --outputChatBox("Wciśnij E aby wyjść", he, 255, 255, 255)
    bindKey(he, "e", "down", wyjdzIntek)
    data_powrot = getElementData(source, "uidint_powrot")
    fadeCamera(he, true)
end

addEventHandler("onPickupHit", root, function()
    cancelEvent()
end)

function wyjdzIntek(he, md)
    wyjscie = exports["bc_db"]:dbGet("SELECT * FROM drzwi WHERE id=?", data_powrot)
    for i, v in pairs(wyjscie) do
        out_x = v.x
        out_y = v.y
        out_z = v.z
    end
    setElementInterior(he, 0)
    setElementPosition(he, tonumber(out_x), tonumber(out_y), tonumber(out_z))
end

function zbindujKlawisz(he, md)
    if getElementType(he) == "text" or getElementType(he) == "vehicle" then
        cancelEvent()
    else
        bindKey(he, "e", "down", wejdzIntek)
        data = getElementData(source, "uidint")
    end
end

function wejdzIntek(he, md)
    if isPedInVehicle(he) == false then 
        intek = exports["bc_db"]:dbGet("SELECT xw, yw, zw, intid FROM drzwi WHERE id=?", data)
        for i, v in pairs(intek) do
            interior_x = v.xw
            interior_y = v.yw
            interior_z = v.zw
            interior_vid = v.intid
        end
        setElementInterior(he, tonumber(interior_vid))
        setElementPosition(he, tonumber(interior_x), tonumber(interior_y), tonumber(interior_z))
        fadeCamera(he, true)
    else 
        return
    end
end

function usunBind(he, md)
    if getElementType(he) == "vehicle" then
       cancelEvent() 
    else
       unbindKey(he, "e", "down")
    end
end

function usunBindPowrot(he, md)
    unbindKey(he, "e", "down")
end

function postawDrzwi()
    drzwi = exports["bc_db"]:dbGet("SELECT * FROM drzwi")
    for i, v in pairs(drzwi) do
        picint = createPickup(tonumber(v.x), tonumber(v.y), tonumber(v.z)-tonumber(v.offset), 3, tonumber(v.pickid), 0)
        col = createColSphere(tonumber(v.x), tonumber(v.y), tonumber(v.z)-tonumber(v.offset), 1)
        local t=createElement("text")
        setElementInterior(t, 0)
        setElementDimension(t,0)
        setElementPosition(t, tonumber(v.x), tonumber(v.y), tonumber(v.z)-tonumber(v.offset))
        setElementData(t,"name",""..tostring(v.nazwa).."\nKliknij E aby wejść")
        setElementCollisionsEnabled(picint, false)
        setElementData(col, "uidint", v.id)

        addEventHandler("onColShapeHit", col, zbindujKlawisz, false)
        addEventHandler("onColShapeLeave", col, usunBind, false)

        picint_int = createPickup(tonumber(v.xw), tonumber(v.yw), tonumber(v.zw)-tonumber(v.offset), 3, tonumber(v.pickid), 0)
        col_int = createColSphere(tonumber(v.xw), tonumber(v.yw), tonumber(v.zw)-tonumber(v.offset), 1)
        setElementInterior(picint_int, tonumber(v.intid))
        setElementInterior(col_int, tonumber(v.intid))
        setElementCollisionsEnabled(picint_int, false)
        setElementData(col_int, "uidint_powrot", v.id)
        
        addEventHandler("onColShapeHit", col_int, zbindujKlawiszPowrot, false)
        addEventHandler("onColShapeLeave", col_int  , usunBindPowrot, false)
    end
end

addCommandHandler("refint", function(plr, cmd)
local nickname = getAccountName(getPlayerAccount(plr))
    if isObjectInACLGroup("user."..nickname, aclGetGroup("Admin" )) == true then
        outputChatBox("Odswiezono", plr)
        postawDrzwi()
        restartResource(getThisResource())
    else
        return
    end
end)

addCommandHandler("creint", function(plr, cmd, idwlas, nazwa, x, y, z, offset, xw, yw, zw, intid, pickid)
local nickname = getAccountName(getPlayerAccount(plr))
    if isObjectInACLGroup("user."..nickname, aclGetGroup("Admin" )) == true then
        if idwlas == nil or nazwa == nil or x == nil or z == nil or z == nil or offset == nil then
            outputChatBox("Prawidlowe uzycie: /creint <idwlasciciela> <nazwa> <x> <y> <z> <offset> <xw> <yw> <zw> <intid> <pickid>", plr)
        else
            exports["bc_db"]:dbSet("INSERT INTO drzwi (idwlas, nazwa, x, y ,z , offset, xw, yw, zw, intid, pickid) VALUES (?,?,?,?,?,?,?,?,?,?,?)", idwlas, nazwa, x, y, z, offset, xw, yw, zw, intid, pickid)
            postawDrzwi()
        end
    else
        return
    end
end)

addCommandHandler("delint", function(plr, cmd, id)
local nickname = getAccountName(getPlayerAccount(plr))
    if isObjectInACLGroup("user."..nickname, aclGetGroup("Admin" )) == true then
        if id == nil then
            outputChatBox("Podaj poprawne id", plr)
        else
            exports["bc_db"]:dbSet("DELETE FROM drzwi WHERE id=?", id)
            postawDrzwi()
            restartResource(getThisResource())
        end
    end
end)

addEventHandler("onResourceStart", resourceRoot, function()
    postawDrzwi()
end)


