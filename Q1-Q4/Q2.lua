-- Original code
function printSmallGuildNames(memberCount)
	local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
	local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
	local guildName = result.getString("name")
	print(guildName)
end


--[[
	Edits:
		- usage of a prepared statement to avoid possible risks of SQL injection
		- using a prepared statement, we don't need to format the parameter in the query anymore
		- check of the query result and print if it is null
		- if a result exists, we need to loop in it to print ALL guilds names
		- query result closure (it's better to do it explicitly even if Lua has its own garbage collector)
--]]

function printSmallGuildNames(memberCount)
	local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < ?" --prepared statement
	local result = db.storeQuery(selectGuildQuery, memberCount)
	
	if result ~= nil then
		repeat
            local guildName = result.getString("name")
            print(guildName)
        until not result.next()
		
		--close the query result
        result.free()
    else
        print("No result")
    end
end