//-----------------------------------------------------------------------------
// The following are examples of how to use give_tf_weapon.
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Purpose: Give a class a weapon
// Gives Pyro the custom weapon "Hottest Hand" on respawn/resupply
//-----------------------------------------------------------------------------
function OnGameEvent_post_inventory_application(params)
{
	if ("userid" in params)
	{
		local hPlayer = GetPlayerFromUserID(params.userid);	//grab player ID...
		
		hPlayer.GTFW_Cleanup();	//clean up function, deletes unused weapon entities from GiveWeapon.
		EntFireByHandle(hPlayer,"RunScriptCode","self.LoadLoadout()",0.0,hPlayer,hPlayer);	//If a weapon was saved, loads it after respawning or touching resupply
		
		if ( hPlayer.GetPlayerClass() == Constants.ETFClass.TF_CLASS_PYRO )	//If class is Pyro...
		{
			hPlayer.GiveWeapon("Hottest Hand");	//...Give custom weapon "Hottest Hand".
		}
	}
}


//-----------------------------------------------------------------------------
// The following can be placed inside of event.
// Example: `OnGameEvent_post_inventory_application`
//-----------------------------------------------------------------------------
// Purpose: Change a weapon into another weapon if they have it equipped
// If the player has a Rocket Jumper equipped, force player to use the Rocket Launcher instead.
//-----------------------------------------------------------------------------
	
	if ( hPlayer.GetWeapon("Rocket Jumper") ) {
		hPlayer.GiveWeapon("Rocket Launcher");
	}
	
//-----------------------------------------------------------------------------
// Purpose: Change all weapons that aren't specified weapon into another weapon
// If the player *does not* have a Rocket Jumper equipped, force player to use the Rocket Jumper.
//-----------------------------------------------------------------------------
	
	if ( !hPlayer.GetWeapon("Rocket Jumper") ) {
		hPlayer.GiveWeapon("Rocket Jumper");
	}

//-----------------------------------------------------------------------------
// Purpose: Change all Sniper Rifles into the Huntsman
//-----------------------------------------------------------------------------

	if ( !hPlayer.GetWeapon("Huntsman")			//If not Huntsman
	 && !hPlayer.GetWeapon("Fortified Compound")	//and reskins like Fortified Compound + Festive Huntsman
	 && !hPlayer.GetWeapon("Festive Huntsman") ) {
		local HUNTSMAN = hPlayer.GiveWeapon("Huntsman");	//Give the Huntsman
		
	//Huntsman isn't flipped by default. This is a potential fix.
		if ( NetProps.GetPropInt(HUNTSMAN, "m_bFlipViewModel") == 0 ) {
			NetProps.SetPropInt(HUNTSMAN, "m_bFlipViewModel", 1);
		}
	}
	
	
//-----------------------------------------------------------------------------
// Purpose: Force player to switch to specific weapon
// Forces player to switch to melee.
// Note: Weapon_Switch is a function built into vscript, and not a function by give_tf_weapon.
//-----------------------------------------------------------------------------

	hPlayer.Weapon_Switch(player.GetWeaponBySlot(2)); // 2 == melee slot
	
	
//-----------------------------------------------------------------------------
// Purpose: Force player to best weapon (from primary, then secondary, then melee, then anything else)
// Accepts handle only (if applicable)
// Note: Function from give_tf_weapon.
//-----------------------------------------------------------------------------

	hPlayer.SwitchToBest();


//-----------------------------------------------------------------------------
// Purpose: Find max ammo reserve
// Pull max Revolver ammo reserve number from a pre-defined table.
//-----------------------------------------------------------------------------

	local REVOLVER = GetWeaponTableNoPlayer("Revolver");
	//Use this to grab max reserve ammo:
	REVOLVER.reserveMax;
	
	
//-----------------------------------------------------------------------------
// Purpose: Delete a weapon
// Deletes the spellbook from non-Engineer classes
//-----------------------------------------------------------------------------

	if ( hPlayer.GetPlayerClass() != Constants.ETFClass.TF_CLASS_ENGINEER )	//If any class but Engineer
	{
		hPlayer.DeleteWeapon("tf_weapon_spellbook");	//deletes the spellbook entity
	}
	
//-----------------------------------------------------------------------------
// Purpose: Another way to add functions to your weapons
// Gives you entire Engineer weapon set.
//-----------------------------------------------------------------------------

	RegisterCustomWeapon("Engy Toolbox", "Toolbox", null, Defaults, null,
		function (weapon, player){
			player.GiveWeapon("Build PDA");
			player.GiveWeapon("Destroy PDA");
		})
	
	
//-----------------------------------------------------------------------------
// Purpose: Announce weapon to players in chat
// function(weapon, quality=null, prefix=null, has_string="has found:", player_prefix=null)
//-----------------------------------------------------------------------------

	hPlayer.AnnounceWeapon("Family Business","Unusual","Mysterious","has claimed:","The fabulous")
	
	
//-----------------------------------------------------------------------------
// Purpose: Makes a custom wearable
// Gives player the Sole Saviors ( https://wiki.teamfortress.com/wiki/Sole_Saviors )
//-----------------------------------------------------------------------------

	hPlayer.CreateCustomWearable("tf_wearable", "models/workshop/player/items/all_class/sbox2014_armor_shoes/sbox2014_armor_shoes_demo.mdl")
	
	
//-----------------------------------------------------------------------------
// Purpose: Load/Save a specific weapon
//-----------------------------------------------------------------------------

	hPlayer.SaveLoadout(TF_WEAPONSLOTS.MELEE)	//Saves weapon in slot melee
	hPlayer.LoadLoadout(TF_WEAPONSLOTS.MELEE)	//Loads weapon in slot melee
	
//-----------------------------------------------------------------------------
// Purpose: Delete a saved weapon
//-----------------------------------------------------------------------------
	hPlayer.DeleteLoadout(TF_WEAPONSLOTS.MELEE)	//Deletes a previously saved weapon in slot melee

//-----------------------------------------------------------------------------
// Purpose: Delete loadouts for all players
// Note: Restarting a round deletes all loadouts for all players by default.
//-----------------------------------------------------------------------------
	DeleteAllLoadouts()
	
	
//-----------------------------------------------------------------------------
// End file. GTFW v5.1.0.
// Signed `Yaki`, 30 May 2023
//-----------------------------------------------------------------------------