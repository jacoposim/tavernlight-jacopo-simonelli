-- Original code
function do_sth_with_PlayerParty(playerId, membername)
	player = Player(playerId)
	local party = player:getParty()
	
	for k,v in pairs(party:getMembers()) do
		if v == Player(membername) then
			party:removeMember(Player(membername))
		end
	end
end



-- Edits:
-- 	- making the variable player local
-- 	- checks on variables player and party to avoid possible null pointer errors
-- 	- removing of the loop to remove a player from the party: having already the membername as a function input
-- 	  parameter, we don't need to loop into all party members


function do_sth_with_PlayerParty(playerId, membername)
    local player = Player(playerId)
    if player then
        local party = player:getParty()
        if party then
            party:removeMember(Player(membername))
        end
end
