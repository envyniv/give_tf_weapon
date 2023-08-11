//-----------------------------------------------------------------------------
//Purpose: Deletes a weapon equipped on player
// Accepts handles, entity classnames, strings, slots (use negatives)
//-----------------------------------------------------------------------------

::CTFPlayer.DeleteWeapon <- function(weapon=null)
{
	if ( weapon == null ) {
		GTFW.DevPrint(1,"DeleteWeapon", "Function failed. Parameter is null. Returning false.");
		return false;
	}
	
//converts our weapon from string/ID to an itemID...
	local table = this.GetWeaponTable(weapon)
	if ( table == null ) {
		GTFW.DevPrint(1,"DeleteWeapon", "Function failed. Could not find \x22"+weapon+"\x22. Returning null.");
		return false;
	}
	local player = this;
	local WepC = table.classname;
	local DeleteThis = table.itemID;
	local Slot = table.slot;
	local wep;
	
// Searches passive weapons like Gunboats, Targe, etc. and deletes it
	if ( SearchPassiveItems.find(WepC) ) {
		wep = player.GetPassiveWeaponBySlot(Slot);
		if ( wep )
			KillWepAll(wep);
	}
// Searches for anything not passive and deletes that
	else {
		for (local i = 0; i < GLOBAL_WEAPON_COUNT; i++)
		{
			wep = GetPropEntityArray(player, "m_hMyWeapons", i);
			
			if ( wep == null ) continue
				if ( GTFW.TestWeaponBySlotBool(wep, weapon) )
				{
					DeleteThis = GetItemID(wep);
				}
				if ( GetItemID(wep) == DeleteThis )
				{
					SetPropEntityArray(player, "m_hMyWeapons", null, i);
					KillWepAll(wep);
					break;
				}
		}
	}
// switches to another weapon if active one was deleted
	if (CVAR_DELETEWEAPON_AUTO_SWITCH) {
		if ( wep == null ) {
			player.SwitchToBest();
		}
	}
	
	return true
}
