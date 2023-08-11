//-----------------------------------------------------------------------------
// Weapon Name: "Half-Life Shotgun"
// Description: Right-Click to fire a crit shit at the cost of 2 ammo
// Coded By:	Yaki
//-----------------------------------------------------------------------------
function CW_Stats_Example_HalfLife_Shotgun (weapon, player)
{	
	weapon.KeyValueFromString("rendercolor", "0 0 0");

	if( weapon.ValidateScriptScope() )
	{
		local main_viewmodel = NetProps.GetPropEntity(player, "m_hViewModel");
		
		local IN_ATTACK = Constants.FButtons.IN_ATTACK;
		local IN_ATTACK2 = Constants.FButtons.IN_ATTACK2;
		const FireSecondaryDelay = 0.8;
		
		local altFireSequence;
		switch ( player.GetPlayerClass() ) {
			case Constants.ETFClass.TF_CLASS_SCOUT : altFireSequence = "fj_fire"; break;
			//case Constants.ETFClass.TF_CLASS_SOLDIER : altFireSequence = "fire"; break;
			//case Constants.ETFClass.TF_CLASS_PYRO : altFireSequence = "fire"; break;
			//case Constants.ETFClass.TF_CLASS_DEMOMAN : altFireSequence = "fire"; break;
			//case Constants.ETFClass.TF_CLASS_HEAVYWEAPONS : altFireSequence = "fire"; break;
			case Constants.ETFClass.TF_CLASS_ENGINEER : altFireSequence = "fj_fire"; break;
			case Constants.ETFClass.TF_CLASS_MEDIC : altFireSequence = "fj_fire"; break;
			//case Constants.ETFClass.TF_CLASS_SNIPER : altFireSequence = "fire"; break;
			case Constants.ETFClass.TF_CLASS_SPY : altFireSequence = "fj_fire"; break;
			default : altFireSequence = "fire"; break;
		}
	
		local scope = weapon.GetScriptScope()
		scope["think_HL_Shotgun"] <- function()	//Our script's name.
		{
            local buttons = NetProps.GetPropInt(player, "m_nButtons");
            local lastFireTimePrimary = NetProps.GetPropFloat(weapon, "LocalActiveWeaponData.m_flNextPrimaryAttack");
            local lastFireTimeSecondary = NetProps.GetPropFloat(weapon, "LocalActiveWeaponData.m_flNextSecondaryAttack");
			local Reloading = NetProps.GetPropInt(weapon, "m_iReloadMode")
			
            if ( buttons & IN_ATTACK2 && buttons & ~IN_ATTACK && !Reloading && weapon.Clip1() >= 2 && lastFireTimeSecondary > lastFireTimePrimary ) {
				NetProps.SetPropBool(player,"m_bLagCompensation",false)
				player.AddCondEx(56,0.1,null)
				weapon.PrimaryAttack()
				weapon.SetClip1(weapon.Clip1() - 1)
				if ( main_viewmodel.GetSequence() != main_viewmodel.LookupSequence(altFireSequence) ) {
					main_viewmodel.SetSequence(main_viewmodel.LookupSequence(altFireSequence) )
				}
				
				NetProps.SetPropFloat(weapon, "LocalActiveWeaponData.m_flNextPrimaryAttack", NetProps.GetPropFloat(weapon, "LocalActiveWeaponData.m_flNextPrimaryAttack")+FireSecondaryDelay);
			}
	//	printl(main_viewmodel.GetSequenceName(main_viewmodel.GetSequence()))
			NetProps.SetPropBool(player,"m_bLagCompensation",true)
			NetProps.SetPropFloat(weapon, "LocalActiveWeaponData.m_flNextSecondaryAttack", lastFireTimePrimary);
			
		//	printl( lastFireTimePrimary-Time() < 0 ? "Can Fire" : lastFireTimePrimary-Time() ) 
			
			return	0.1
		}
		AddThinkToEnt(weapon, "think_HL_Shotgun")	//Adds the think script to handle 'weapon' after it has been validated.
	}
}

	RegisterCustomWeapon("Half-Life Shotgun", "shotgun",
		null,
		Defaults|AnnounceToChat,
		function (table, player) {
			table.clipSize		= 8;
			table.clipSizeMax	= 8;
			table.reserveMax 	= 30;
		},
		CW_Stats_Example_HalfLife_Shotgun)