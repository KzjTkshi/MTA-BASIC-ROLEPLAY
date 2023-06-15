
function getElementSpeed(theElement, unit)
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    local elementType = getElementType(theElement)
    assert(elementType == "player" or elementType == "ped" or elementType == "object" or elementType == "vehicle" or elementType == "projectile", "Invalid element type @ getElementSpeed (player/ped/object/vehicle/projectile expected, got " .. elementType .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    return (Vector3(getElementVelocity(theElement)) * mult).length
end

addEvent("zapalSwiatla", true)
addEventHandler("zapalSwiatla", resourceRoot, function(plr)
    if isPedInVehicle(plr) == true then
        car = getPedOccupiedVehicle(plr)
        if getPedOccupiedVehicleSeat(plr) == 0 then
            if getVehicleOverrideLights(car) ~= 2 then
                setVehicleOverrideLights(car, 2)
                setElementData(plr, "plr:char_ame", "*"..getPlayerName(plr).." zapala światła.")
            else
                setVehicleOverrideLights(car, 1)
                setElementData(plr, "plr:char_ame", "*"..getPlayerName(plr).." gasi światła.")
             end
        else
            return
        end
    else
        return
    end
end)

addEvent("zapalSilnik", true)
addEventHandler("zapalSilnik", resourceRoot, function(plr)
    if isPedInVehicle(plr) == true then
        car = getPedOccupiedVehicle(plr)
        if getPedOccupiedVehicleSeat(plr) == 0 then
            if getVehicleEngineState(car) == false then
                setVehicleEngineState(car, true)
                setElementData(plr, "plr:char_ame", "*"..getPlayerName(plr).." przekręca kluczyk w stacyjce.")
            else
                setVehicleEngineState(car, false)
                setElementData(plr, "plr:char_ame", "*"..getPlayerName(plr).." gasi silnik.")
            end
        else
            return
        end
    else
        return
    end
end)

addEvent("zaciagnijReczny", true)
addEventHandler("zaciagnijReczny", resourceRoot, function(plr)
    if isPedInVehicle(plr) == true then
        car = getPedOccupiedVehicle(plr)
        if getPedOccupiedVehicleSeat(plr) == 0 then
            if getElementSpeed(car, 1) <= 3 then
                if isElementFrozen(car) then
                    setElementFrozen(car, false)
                    setElementData(plr, "plr:char_ame", "*"..getPlayerName(plr).." spuszcza ręczny.")
                else
                    setElementFrozen(car, true)
                    setElementData(plr, "plr:char_ame", "*"..getPlayerName(plr).." zaciąga ręczny.")
                end
            end
        else
            return
        end
    else
        return
    end
end)

addEvent("zamknijDrzwi", true)
addEventHandler("zamknijDrzwi", resourceRoot, function(plr)
    if isPedInVehicle(plr) == true then
        car = getPedOccupiedVehicle(plr)
        if getPedOccupiedVehicleSeat(plr) == 0 then
            if isVehicleLocked(car) == true then
                setVehicleLocked(car, false)
                setElementData(plr, "plr:char_ame", "*"..getPlayerName(plr).." otwiera drzwi.")
            else
                setVehicleLocked(car, true)
                setElementData(plr, "plr:char_ame", "*"..getPlayerName(plr).." zamyka drzwi.")
            end
        else
            return
        end
    else
        return
    end
end)

addEvent("otworzBagaznik", true)
addEventHandler("otworzBagaznik", resourceRoot, function(plr)
    if isPedInVehicle(plr) == true then
        car = getPedOccupiedVehicle(plr)
        if getPedOccupiedVehicleSeat(plr) == 0 then
            if getVehicleDoorOpenRatio(car, 1) == 1 then
                setVehicleDoorOpenRatio(car, 1, 0)
                setElementData(plr, "plr:char_ame", "*"..getPlayerName(plr).." zamyka bagażnik.")
            else
                setVehicleDoorOpenRatio(car, 1, 1)
                setElementData(plr, "plr:char_ame", "*"..getPlayerName(plr).." otwiera bagażnik.")
            end
        else
            return
        end
    else
        return
    end
end)

addEvent("otworzMaske", true)
addEventHandler("otworzMaske", resourceRoot, function(plr)
    if isPedInVehicle(plr) == true then
        car = getPedOccupiedVehicle(plr)
        if getPedOccupiedVehicleSeat(plr) == 0 then
            if getVehicleDoorOpenRatio(car, 0) == 1 then
                setVehicleDoorOpenRatio(car, 0, 0)
                setElementData(plr, "plr:char_ame", "*"..getPlayerName(plr).." zamyka maske.")
            else
                setVehicleDoorOpenRatio(car, 0, 1)
                setElementData(plr, "plr:char_ame", "*"..getPlayerName(plr).." otwiera maske.")
            end
        else
            return
        end
    else
        return
    end
end)

