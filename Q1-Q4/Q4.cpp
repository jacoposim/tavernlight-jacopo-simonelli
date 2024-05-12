// Original code
void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
	Player* player = g_game.getPlayerByName(recipient);
	
	if (!player) {
		player = new Player(nullptr); //new must be released -> delete?
		
		if (!IOLoginData::loadPlayerByName(player, recipient)) {
			return;
		}
	}

	Item* item = Item::CreateItem(itemId);
	if (!item) {
		return;
	}

	g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

	if (player->isOffline()) {
		IOLoginData::savePlayer(player);
	}
}


/*
	Edits:
		- using "new" to create the player object, we are creating an object with dynamic storage duration,
		  so it wont't be cleaned up automatically, and we need to delete it when it is not useful anymore
		  otherwise the memory allocated for it will be lost
*/

void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = g_game.getPlayerByName(recipient);
    bool playerCreated = false; //player creation flag

    if (!player) {
        player = new Player(nullptr);
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            delete player; //free the memory if the player is not loaded 
            return;
        }
        playerCreated = true;
    }

    Item* item = Item::CreateItem(itemId);
    if (!item) {
        if (playerCreated) {
            delete player; //free the memory if the item creation fails
        }
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
    }

    if (playerCreated) {
        delete player; //after the item is added correctly, free the memory
    }
}