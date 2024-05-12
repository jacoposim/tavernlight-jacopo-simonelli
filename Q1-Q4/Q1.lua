-- Original code
local function releaseStorage(player)
	player:setStorageValue(1000, -1)
end

function onLogout(player)
	if player:getStorageValue(1000) == 1 then
		addEvent(releaseStorage, 1000, player)
	end
	
	return true
end


--[[
	Edits:
		- introduction of STORAGE_ID constant to make the code more manageable and readable
		- removal of external function call to avoid possible overhead
--]]

local STORAGE_ID = 1000

function onLogout(player)
	if player:getStorageValue(STORAGE_ID) == 1 then
		addEvent(function(player) player:setStorageValue(STORAGE_ID, -1) end, 1000, player)
	end
	
	return true
end