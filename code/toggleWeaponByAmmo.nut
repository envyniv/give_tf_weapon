//-----------------------------------------------------------------------------
// Purpose: disables being able to switch to a weapon.
//-----------------------------------------------------------------------------

::CTFPlayer.DisableWeapon <- function(weapon=null)
{
//Error if param is null
	if ( weapon == null ) {
		GTFW.DevPrint(1,"DisableWeapon", "Function failed. Parameter is null. Returning null.");
		return null;
	}
//searches for the correct item based on parameter 'weapon'...
	local table = this.GetWeaponTable(weapon);
	if ( table == null ) {
		GTFW.DevPrint(1,"DisableWeapon", "Function failed. Could not find \x22"+weapon+"\x22. Returning null.");
		return null;
	}
	
	local DisableThis = table.itemID
	
	local BrokenGun;
	local wep;
	
	for (local i = 0; i < GLOBAL_WEAPON_COUNT; i++)
	{
		local wep = GetPropEntityArray(this, "m_hMyWeapons", i);
		
		if ( wep )
		{
			if ( GTFW.TestWeaponBySlotBool(wep, weapon) )
			{
				DisableThis = GetItemID(wep);
			}
			if ( GetItemID(wep) == DisableThis )
			{
				local AmmoFix = GTFW.GetAmmoFix(this);
				
				if ( wep.GetPrimaryAmmoType() == TF_AMMO.PRIMARY ) {
					AmmoFix.AddAttribute("maxammo primary reduced", 0, -1);
					AmmoFix.ReapplyProvision();
					EntityOutputs.AddOutput(AmmoFix, "OnUser1", "", "", "", 0.0, -1);	//used to flag for Primary Ammo
				}
				else if ( wep.GetPrimaryAmmoType() == TF_AMMO.SECONDARY ) {
					AmmoFix.AddAttribute("maxammo secondary reduced", 0, -1);
					AmmoFix.ReapplyProvision();
					EntityOutputs.AddOutput(AmmoFix, "OnUser2", "", "", "", 0.0, -1);	//used to flag for Secondary Ammo
				}
				else if ( wep.GetPrimaryAmmoType() == TF_AMMO.GRENADES1 ) {
					AmmoFix.AddAttribute("maxammo grenades1 increased", 0, -1);
					AmmoFix.ReapplyProvision();
					EntityOutputs.AddOutput(AmmoFix, "OnUser4", "", "", "", 0.0, -1);	//used to flag for GRENADES1 Ammo
				}
				wep.SetClip1(0);
				SetPropIntArray(this, "m_iAmmo", 0, wep.GetPrimaryAmmoType());
				
				BrokenGun = wep;
				break;
			}
		}
	}
	
// switches to another weapon if active one was disabled
	if (CVAR_DISABLEWEAPON_AUTO_SWITCH) {
		this.SwitchToBest(null);
	}
	
	return BrokenGun;
}


//-----------------------------------------------------------------------------
//Purpose: Enables weapon if it was disabled.
//-----------------------------------------------------------------------------
::CTFPlayer.EnableWeapon <- function(weapon=null)
{
//Error if param is null
	if ( weapon == null ) {
		GTFW.DevPrint(1,"EnableWeapon", "Function failed. Parameter is null. Returning null.");
		return null;
	}
	local FixThis = null;
//searches for the correct item based on parameter 'weapon'...
	local table = this.GetWeaponTable(weapon);
	if ( table == null ) {
		GTFW.DevPrint(1,"EnableWeapon", "Function failed. Could not find \x22"+weapon+"\x22. Returning null.");
		return null;
	}
	
	FixThis = table.itemID;
	
	local FixedGun;
	
	for (local i = 0; i < GLOBAL_WEAPON_COUNT; i++)
	{
		local wep = GetPropEntityArray(this, "m_hMyWeapons", i);
		
		if ( wep )
		{
			if ( GTFW.TestWeaponBySlotBool(wep, weapon) )
			{
				FixThis = GetItemID(wep);
			}
			if ( GetItemID(wep) == FixThis )
			{
				local AmmoFix = GTFW.GetAmmoFix(this);
				
				if ( wep.GetPrimaryAmmoType() == TF_AMMO.PRIMARY ) {
					AmmoFix.AddAttribute("maxammo primary reduced", 1, -1);
					AmmoFix.ReapplyProvision();
					EntityOutputs.RemoveOutput(AmmoFix, "OnUser1", "", "", "");	//used to flag for Primary Ammo
				}
				else if ( wep.GetPrimaryAmmoType() == TF_AMMO.SECONDARY ) {
					AmmoFix.AddAttribute("maxammo secondary reduced", 1, -1);
					AmmoFix.ReapplyProvision();
					EntityOutputs.RemoveOutput(AmmoFix, "OnUser2", "", "", "");	//used to flag for Secondary Ammo
				}
				else if ( wep.GetPrimaryAmmoType() == TF_AMMO.GRENADES1 ) {
					AmmoFix.AddAttribute("maxammo grenades1 increased", 1, -1);
					AmmoFix.ReapplyProvision();
					EntityOutputs.RemoveOutput(AmmoFix, "OnUser4", "", "", "");	//used to flag for GRENADES1 Ammo
				}
				
				FixedGun = wep;
				break;
			}
		}
	}
	
// switches to another weapon if active one was disabled

	if (CVAR_ENABLEWEAPON_AUTO_SWITCH) {
		this.SwitchToBest(FixedGun);
	}
	
	return FixedGun;
}

