//-----------------------------------------------------------------------------
// Purpose: "!give" command in chat
//			Write "!give tomislav" to give typist a tomislav
//			Write "!give all shotgun" to give all bots a shotgun (requires CVAR_GTFW_DEBUG_MODE = true)
//			Write "!give !picker GRU MVM" to give aiming target the GRU MVM (requires CVAR_GTFW_DEBUG_MODE = true)
// Made By: Yaki
//-----------------------------------------------------------------------------


function OnGameEvent_player_say(params)
{
	//Define variables
	local player = GetPlayerFromUserID(params.userid);	//User typing the message in chat
	local msg = params.text;	//what they said
	msg = msg.tolower();	//make all letters lowercase; for QoL 
	local msg_split = split(msg, " ");	//splits messages into an array with spaces as the divider; it gives us an easier way to see what's been said
	
// If there is no message
// Checks for message string length
	if ( msg.len() == 0 ) { return; }
	
//Main function
// Checks for "!give" in chat
// If "!give !picker", then checks for weapon name.
// If "!give", then checks for weapon name.
	if ( msg_split.len() >= 1 && msg_split[0] == "!give") // Checks if array is greater than 1, and if message in array slot 0 == "!give"
	{
	//"!picker"
		if (CVAR_GTFW_DEBUG_MODE && msg_split.len() >= 2 && msg_split[1] == "!picker") {	// Checks if array is greater than 2, and if second message is "!picker"
		
			local picker = player.FindPicker(); // New function Yaki made called CTFPlayer.FindPicker(); see below for function details
			
			if ( picker && picker.IsPlayer() ) {	//if our handle is valid and is a player
				if (msg.len() > 14 ) {				// if our message length is greater than 14 for us to slice
					local weapon = msg.slice(14);	// culls "!give !picker "
					if ( weapon )					// if anything else in chat
						picker.GiveWeapon(weapon);	// runs GiveWeapon()
				}
			}
			else { ClientPrint(player,3,"\x05[VScript] \x01Invalid target."); return; }
		}
	//"all"
		else if (CVAR_GTFW_DEBUG_MODE && msg_split.len() >= 2 && msg_split[1] == "all") {	// Checks if array is greater than 2, and if second message is "all"
		
			if (msg.len() > 10 ) {				// if our message length is greater than 10 for us to slice
				local weapon = msg.slice(10);	// culls "!give all "
				if ( weapon ) {					// if anything else in chat
				//Runs a loop to grab all players on the server; Example on VDC ( https://developer.valvesoftware.com/wiki/TF2_VScript_Examples )
					for (local i = 1; i <= Constants.Server.MAX_PLAYERS; i++)
					{
						local bot = PlayerInstanceFromIndex(i)
						if (bot == null) continue	//if player exists in server
							if ( IsPlayerABot(bot) == true )	//if it is a bot
								bot.GiveWeapon(weapon);	// runs GiveWeapon()
					}
				}
			}
		}
	//weapon name
		else {
			local weapon = msg.slice(6);
			if ( weapon )
				player.GiveWeapon(weapon);
		}
	}
}
	__CollectGameEventCallbacks(this)

// New function
// Grabs target in front of player in a straight line for us to use as a handle
// Very flexible function; Keep somewhere safe, because it is always handy to use!
::CTFPlayer.FindPicker <- function()
{
	local player = this;
	
//creates a table for TraceLineEx
	local table = {
		start = player.EyePosition() + player.GetForwardVector(),	//start position is player's eye position
		end = player.EyePosition()+(player.EyeAngles().Forward()*9999),	//end position is coordinate player eye position + (where they're facing*9999 distance)
		ignore = player,
	}
	
//Runs TraceLineEx, and returns all the stuff traced from the function back into table
	TraceLineEx(table)
	
// Checks if there was an ent found
	if ( "enthit" in table ) {
		local picker = table.enthit;	//defines picker as table.enthit
		return picker;	//returns handle for us to use!
	}
	return null	//if it didn't find anything, returns null. (Which might be impossible? it might return null if you trace into the void?)
}