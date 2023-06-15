--[[

@author: ohdude
@project: bonecounty-rp.pl

]]


addEventHandler("onPlayerQuit", root, function()
    local uid = getElementData(source, "plr:char_uid")
    local kasa = getPlayerMoney(source)
    local przegrane_minuty = getElementData(source, "plr:char_minuty")
    local stan_konta = getElementData(source, "plr:char_stankonta")
    exports["bc_db"]:dbSet("UPDATE characters SET gotowka=?, stankonta=?,  minuty=? WHERE id=?", tostring(kasa), tostring(stan_konta), tostring(przegrane_minuty), tonumber(uid))
end)