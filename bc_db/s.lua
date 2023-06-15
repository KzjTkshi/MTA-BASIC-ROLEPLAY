DBHandler=nil
DBName="db_56747"
DBUser="db_56747"
DBPass="C3ELibAw7zRp"
DBHost="51.83.136.0"

function dbSet(...)
	if not {...} then return end
	local query=dbExec(DBHandler, ...)
	return query
end

function dbGet(...)
	if not {...} then return end
	local query=dbQuery(DBHandler, ...)
	local result=dbPoll(query, -1)
	return result
end

addEventHandler("onResourceStart", resourceRoot, function()
	DBHandler=dbConnect("mysql", "dbname="..DBName..";host="..DBHost.."", DBUser, DBPass, "share=1")
	if DBHandler then
		outputDebugString("* Połączono")
	else
		outputDebugString("* Wystąpił błąd")
	end
end)