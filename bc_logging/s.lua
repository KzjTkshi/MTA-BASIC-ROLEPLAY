--[[

@project: bonecounty-rp.pl
@author: ohdude

]]

addEventHandler("onPlayerJoin", root, function()
    setCameraMatrix(source, -2128.44, -2523.62, 44.17)
    fadeCamera(source, true)
    local components = {"weapon", "ammo", "health", "clock", "money", "breath", "armour", "wanted", "radar", "area_name"}
    for _,component in ipairs(components) do
        setPlayerHudComponentVisible(source, component, false)
    end
end)

addEvent("sprawdzLogowanie", true)
addEventHandler("sprawdzLogowanie", resourceRoot, function(login, pass, cel)
    local wynik = exports["bc_db"]:dbGet("SELECT * FROM users WHERE username=?", login)
    local playerh = getPlayerFromName(cel)
    if wynik and #wynik > 0 then
        local passdb = wynik[1].password
        uid = wynik[1].id
        if pass == passdb then
            setElementData(playerh, "plr:uid", tostring(uid))
            triggerClientEvent(playerh, "schowajGui", resourceRoot)

            local wynik = exports["bc_db"]:dbGet("SELECT * FROM characters WHERE idgracz=?", uid)
            triggerClientEvent(playerh, "podajWynik", resourceRoot, wynik)
            
        else
            outputChatBox("Wpisales nie poprawne haslo", playerh)
        end
    else
        outputChatBox("Nie ma takiego konta", playerh)
    end
end)

addEvent("rejestrujMnie", true)
addEventHandler("rejestrujMnie", resourceRoot, function(login, pass, cel, passget)
    if string.len(passget) >= 3 and string.len(login) >= 3 then
        local wynik = exports["bc_db"]:dbGet("SELECT * FROM users WHERE username=?", login)
        playerh = getPlayerFromName(cel)
        if wynik and #wynik == 0 then
            local query=exports["bc_db"]:dbSet("INSERT INTO users (username,password) VALUES (?,?)", login, pass)
            outputChatBox("Rejestracja udana mozesz sie zalogowac", playerh, 255, 255, 255)
        else
            outputChatBox("Podany login jest zajety", playerh, 255, 255, 255)
        end
    else
        outputChatBox("Haslo i login byc rowne lub dluzsze niz 3 znaki", getPlayerFromName(cel), 255, 255, 255)
    end
end)

addEvent("zrespGracza", true)
addEventHandler("zrespGracza", resourceRoot, function(nickname, nickgoscia)
    local playerh = getPlayerFromName(nickgoscia)
    spawnPlayer(playerh, -202.47, 1119.00, 19.74)
    fadeCamera(playerh, true)
    setPlayerName(playerh, nickname)
    setCameraTarget(playerh, playerh)

    local uidgracz = getElementData(playerh, "plr:uid")
    local nickname = getPlayerName(playerh)
    local znajdzuid = exports["bc_db"]:dbGet("SELECT * FROM characters WHERE idgracz=? AND nickname=?", uidgracz, nickname)
    for i, v in ipairs(znajdzuid) do
        uidpostaci = tostring(v.id)
        plec = tostring(v.plec)
        wiek = tostring(v.wiek)
        stankonta = tostring(v.stankonta)
        minuty = tostring(v.minuty)
        skin = tostring(v.skin)
        gotowka = tonumber(v.gotowka)
    end

    setElementData(playerh, "plr:char_skin", skin)
    setElementModel(playerh, tonumber(skin))
    setElementData(playerh, "plr:char_uid", uidpostaci)
    setElementData(playerh, "plr:char_wiek", wiek)
    setElementData(playerh, "plr:char_stankonta", stankonta)
    setElementData(playerh, "plr:char_minuty", minuty)
    setElementData(playerh, "plr:logged", true)
    setPlayerMoney(playerh, gotowka)

    if plec == "0" then
        setElementData(playerh, "plr:char_plec", "Kobieta")
    else
        setElementData(playerh, "plr:char_plec", "Mężczyzna")
    end

    for i = 1,30 do
        outputChatBox(" ", playerh)
    end
    outputChatBox("Zalogowano pomyślnie na postać "..string.gsub(getPlayerName(playerh), "_", " ").." (UID: "..tostring(getElementData(playerh, "plr:char_uid")).."). Miłej gry!", playerh, 255, 255, 255)

    local components = {"weapon", "ammo", "health", "money", "breath", "armour", "wanted", "radar", "area_name"}
    for _,component in ipairs(components) do
        setPlayerHudComponentVisible(playerh, component, true)
    end

    local ustalSpawn = exports["bc_db"]:dbGet("SELECT * FROM drzwi WHERE idwlas=?", getElementData(playerh, "plr:char_uid"))
    if ustalSpawn and #ustalSpawn > 0 then
        for i, v in ipairs(ustalSpawn) do
            dom_x = tonumber(v.x)
            dom_y = tonumber(v.y)
            dom_z = tonumber(v.z)
        end
        if type(dom_x) == "number" then
            setElementPosition(playerh, dom_x, dom_y, dom_z)
        end
    else
        return
    end
    setPlayerHudComponentVisible(playerh, "clock", false)
end)