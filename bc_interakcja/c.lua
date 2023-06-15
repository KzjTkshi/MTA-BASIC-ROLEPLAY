
function zapalSwiatlaC()
    triggerServerEvent("zapalSwiatla", resourceRoot, localPlayer)
end

function zapalSilnikC()
    triggerServerEvent("zapalSilnik", resourceRoot, localPlayer)
end

function zamknijDrzwiC()
    triggerServerEvent("zamknijDrzwi", resourceRoot, localPlayer)
end

function zaciagnijRecznyC()
    triggerServerEvent("zaciagnijReczny", resourceRoot, localPlayer)
end

function otworzBagaznikC()
    triggerServerEvent("otworzBagaznik", resourceRoot, localPlayer)
end

function otworzMaskeC()
    triggerServerEvent("otworzMaske", resourceRoot, localPlayer)
end

addEventHandler("onClientResourceStart", resourceRoot, function()
    bindKey("l", "down", zapalSwiatlaC)
    bindKey("k", "down", zapalSilnikC)
    bindKey("j", "down", zamknijDrzwiC)
    bindKey("lalt", "down", zaciagnijRecznyC)
    bindKey("b", "down", otworzBagaznikC)
    bindKey("m", "down", otworzMaskeC)
end)