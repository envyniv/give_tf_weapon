//-----------------------------------------------------------------------------
// Purpose: Weapons persisting between resupply functions
//			Relies on "logic_relay", an entity that expires after a round has restarted.
//			Can change "logic_relay" to "move_rope" instead, to persist between rounds. (Would need to update DeleteAllLoadous if using this workaround)
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//	Uses scope of the "logic_relay" to create a loadout save-system.
//	Creates easy cleanup, but might be messy if trying to keep ent-count low.
//	Stores 80 variables, 8 per class (including Civilian)
//	1-7 can all be active weapons, however 8 and up are considered body/passive items. Used for passive parachute, tf_wearable, or anything else you want there.
//-----------------------------------------------------------------------------

//Constants
const GTFW_MAXITEM_PERCLASS = 8;	//Max number of items you can save
const GTFW_MAX_TFCLASSES = 10;		//Max number of TF2 Classes there are


//-----------------------------------------------------------------------------
//	Debug: prints loadout for player
//-----------------------------------------------------------------------------
::CTFPlayer.printloadout <- function()
{
	local Name = format("gtfw_save_%s",GTFW.GetNetName(this));
	local relay = Entities.FindByName(null, Name);
		relay.ValidateScriptScope();
	local scope = relay.GetScriptScope();
	
	for(local i = 0; i<=GTFW_MAXITEM_PERCLASS*GTFW_MAX_TFCLASSES;i++)
	{
		printl(i+" "+scope.Weapon_ID[i])
	}
}


//-----------------------------------------------------------------------------
//	Deletes Loadouts from all players
//-----------------------------------------------------------------------------
::DeleteAllLoadouts <- function() {
	DoEntFire("gtfw_save_*","Trigger",null,0.0,null,null);
	GTFW.DevPrint(0,"DeleteAllLoadouts", "Wiped saved inventory for all players.");
}


//-----------------------------------------------------------------------------
//	Save Loadout
//-----------------------------------------------------------------------------

::CTFPlayer.SaveLoadout <- function(wep=null,optional_tfclass=null) {
	local ply = this;
	local tfclass = null;
	if ( type(optional_tfclass) != "integer" && optional_tfclass != null ) {
		GTFW.DevPrint(true,"SaveLoadout", "Parameter 2 is not an integer.");
		return null;
	}
	else {
		if ( optional_tfclass ) tfclass = optional_tfclass;
		else tfclass = ply.GetPlayerClass();
	}
	
	local scope;
	local Name = format("gtfw_save_%s",GTFW.GetNetName(ply));
	local relay = Entities.FindByName(null, Name);
	if ( !relay ) {
		
		relay = SpawnEntityFromTable("logic_relay", {
			targetname = Name,
			spawnflags = 1,
		})
		
		relay.ValidateScriptScope();
		scope = relay.GetScriptScope();
		
		if ( !("Weapon_ID" in scope ) ) {
			scope.Weapon_ID <- [-1];
			for (local i = 1; i <= GTFW_MAXITEM_PERCLASS*GTFW_MAX_TFCLASSES; i++)
			{
				scope.Weapon_ID.append(-1);
			}
		}
	}
	else {
		relay.ValidateScriptScope();
		scope = relay.GetScriptScope();
	}
	
	if ( wep == null ) {
		for (local i = 0; i < GLOBAL_WEAPON_COUNT; i++)
		{
			local wep = NetProps.GetPropEntityArray(ply, "m_hMyWeapons", i);
			if ( wep == null ) continue
				local WepID = GetItemID(wep);
				
				local index = tfclass*GTFW_MAXITEM_PERCLASS-GTFW_MAXITEM_PERCLASS+1+wep.GetSlot();
				
				scope.Weapon_ID.remove(index);
				scope.Weapon_ID.insert(index, WepID);
				
				GTFW.DevPrint(0,"SaveLoadout", "Saved "+GTFW.GetNetName(ply)+" (as TFClass "+tfclass+") (slot "+index+") : "+wep+" "+WepID);
		}
		return relay;
	}
	else if ( wep ) {
		local table = ply.GetWeaponTable(wep);
		if ( table == null ) {
			GTFW.DevPrint(true,"SaveLoadout", "Failed to find weapon \x22"+wep+"\x22.");
			return relay;
		}
		
		local index = ply.GetPlayerClass()*GTFW_MAXITEM_PERCLASS-GTFW_MAXITEM_PERCLASS+1+table.slot;
		
		scope.Weapon_ID.remove(index);
		scope.Weapon_ID.insert(index, table.itemID);
		
		GTFW.DevPrint(0,"SaveLoadout", "Saved "+GTFW.GetNetName(ply)+" (as TFClass "+tfclass+") (slot "+index+") : "+table.itemID);
		return relay;
	}
	if ( wep )
		GTFW.DevPrint(true,"SaveLoadout", "Did not save "+GTFW.GetNetName(ply)+" weapon "+wep);
	else
		GTFW.DevPrint(true,"SaveLoadout", "Did not save "+GTFW.GetNetName(ply)+" loadout.");
	return relay;
}


//-----------------------------------------------------------------------------
//	Load Loadout
//-----------------------------------------------------------------------------

::CTFPlayer.LoadLoadout <- function(loadThis=null,optional_tfclass=null) {
	
	local ply = this;
	local tfclass = null
	if ( type(optional_tfclass) != "integer" && optional_tfclass != null ) {
		GTFW.DevPrint(true,"LoadLoadout", "Parameter 2 is not an integer.");
		return null;
	}
	else {
		if ( optional_tfclass ) tfclass = optional_tfclass;
		else tfclass = ply.GetPlayerClass();
	}
	
	local scope;
	local Name = format("gtfw_save_%s",GTFW.GetNetName(ply))
	local relay = Entities.FindByName(null, Name);
	if ( !relay ) {
		
		relay = SpawnEntityFromTable("logic_relay", {
			targetname = Name,
			spawnflags = 1,
		})
		
		relay.ValidateScriptScope();
		scope = relay.GetScriptScope();
		
		if ( !("Weapon_ID" in scope ) ) {
			scope.Weapon_ID <- [-1];
			for (local i = 1; i <= GTFW_MAXITEM_PERCLASS*GTFW_MAX_TFCLASSES; i++)
			{
				scope.Weapon_ID.append(-1);
			}
		}
	}
	else {
		relay.ValidateScriptScope();
		scope = relay.GetScriptScope();
	}
	
	if ( loadThis == null ) {
		GTFW.DevPrint(0,"LoadLoadout", "Loaded weapons list for "+GTFW.GetNetName(ply));
		for ( local i = ply.GetPlayerClass()*GTFW_MAXITEM_PERCLASS; i >= ply.GetPlayerClass()*GTFW_MAXITEM_PERCLASS-GTFW_MAXITEM_PERCLASS+1; --i )
		{
			local wep = scope.Weapon_ID[i];
			
			if ( wep && wep != -1 ) {
				GTFW.DevPrint(0,"slot" + (i-(tfclass*GTFW_MAXITEM_PERCLASS-GTFW_MAXITEM_PERCLASS+1)).tostring(), wep);
				ply.GiveWeapon(wep);
			}
		}
	}
	else {
		local table = ply.GetWeaponTable(loadThis)
		if ( table == null ) {
			GTFW.DevPrint(true,"LoadLoadout", "Failed to find weapon \x22"+loadThis+"\x22.");
			return relay;
		}
		
		local i = tfclass*GTFW_MAXITEM_PERCLASS-GTFW_MAXITEM_PERCLASS+table.slot;
		local wep = scope.Weapon_ID[i];
		
		if ( wep != -1 ) {
			ply.GiveWeapon(wep);
			GTFW.DevPrint(0,"LoadLoadout", "Loaded item " + table.name);
			return relay;
		}
			
		GTFW.DevPrint(true,"LoadLoadout", "Could not load slot " + (abs(i-GTFW_MAXITEM_PERCLASS*GTFW_MAX_TFCLASSES)).tostring());
		return relay;
	}
}


//-----------------------------------------------------------------------------
//	Delete Loadout
//-----------------------------------------------------------------------------

::CTFPlayer.DeleteLoadout <- function(wep=null, optional_tfclass=null) {
	
	local ply = this;
	local tfclass = null;
	if ( type(optional_tfclass) != "integer" && optional_tfclass != null ) {
		GTFW.DevPrint(true,"LoadLoadout", "Parameter 2 is not an integer.");
		return null;
	}
	else {
		if ( optional_tfclass ) tfclass = optional_tfclass;
		else tfclass = ply.GetPlayerClass();
	}
	
	local Name = format("gtfw_save_%s",GTFW.GetNetName(ply))
	local scope = null
	local relay = Entities.FindByName(null, Name);
	if ( relay && relay.ValidateScriptScope() ) {
		
		scope = relay.GetScriptScope()
		
		if ( wep == null ) {
	
			scope.Weapon_ID <- [-1]
			for (local i = 1; i <= GTFW_MAXITEM_PERCLASS*GTFW_MAX_TFCLASSES; i++)
			{
				scope.Weapon_ID.append(-1)
			}
			
			GTFW.DevPrint(0,"DeleteLoadout", "Deleted loadout for "+GTFW.GetNetName(ply)+" (ent : "+Name+" )")
			return relay
		}
		else {
			
			local table = ply.GetWeaponTable(wep)
			
			if ( table == null ) {
				GTFW.DevPrint(true,"DeleteLoadout", "Failed to find weapon \x22"+wep+"\x22.")
				return relay
			}
			
			local i = tfclass*GTFW_MAXITEM_PERCLASS-GTFW_MAXITEM_PERCLASS+1+table.slot
			
			wep = scope.Weapon_ID[i]
			
			scope.Weapon_ID.remove(i)
			scope.Weapon_ID.insert(i, -1)
				
		//	GTFW.DevPrint(true,"Deleted slot " + (abs(i-GTFW_MAXITEM_PERCLASS*GTFW_MAX_TFCLASSES)).tostring(), table.name)
			return relay
		}
	}
	GTFW.DevPrint(true,"DeleteLoadout", "Could not delete "+GTFW.GetNetName(ply)+" loadout.")
}
