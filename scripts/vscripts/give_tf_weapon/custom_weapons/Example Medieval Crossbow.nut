//-----------------------------------------------------------------------------
// Weapon Name: "Medieval Crossbow"
// Description: Based off the shotguns
//				Basically a shotgun that shoots arrows
//				Also slows the player while reloading
// Coded by:	Yaki
//-----------------------------------------------------------------------------
function CW_Stats_Example_Scout_Medieval_Crossbow(weapon, player)
{
//	Our attributes
	weapon.AddAttribute("override projectile type", 8, -1);	//shoots Huntsman arrows! (that headshot!) values list: https://forums.alliedmods.net/showthread.php?t=285982
	weapon.AddAttribute("damage penalty", 6.67, -1);		// Since it's over the shotgun, arrows deal pellet damage. INCREASE IT!
	weapon.AddAttribute("Reload time decreased", 0.667, -1);	//REDUCE RELOAD SPEED!
	
	//ALWAYS ent.ValidateScriptScope() before ent.GetScriptScope()
	if( weapon.ValidateScriptScope() )
	{
//	Define variables
	// lastFireTime = last primary attack server time
		local lastFireTime = NetProps.GetPropFloat(weapon, "LocalActiveWeaponData.m_flNextPrimaryAttack");
	// IN_ATTACK = Constant for IN_ATTACK (for better readability on our part)
		local IN_ATTACK = Constants.FButtons.IN_ATTACK
		
//This is our think script. What it does is constantly runs in the background, checking for what ever we put in it.
		local entityscript = weapon.GetScriptScope()
		entityscript["think_SlowPlayerDuringReload"] <- function()	//Our script's name.
		{
	//Part 1 of 2
	//Every time we shoot, it updates the arrow velocity to go where we are aiming.
		// Define variables:
            local buttons = NetProps.GetPropInt(player, "m_nButtons");
            local lastFireTimeNew = NetProps.GetPropFloat(weapon, "LocalActiveWeaponData.m_flNextPrimaryAttack");
			local reloading = NetProps.GetPropInt(weapon, "m_iReloadMode")
		
		// Then...	
            if (buttons & IN_ATTACK	//If using +attack, aka holding Mouse1...
			 && !reloading			//...and if not reloading...
			 && lastFireTimeNew > lastFireTime ) {	//If lastFireTimeNew is greater than lastFireTime
				local arrow;
				while (arrow = Entities.FindByClassname(arrow, "tf_projectile_arrow"))
				{
					if ( arrow.GetOwner() == player ) {
						arrow.__KeyValueFromString("classname", "")
						arrow.SetAbsVelocity(arrow.GetOwner().EyeAngles().Forward()*2400)
						arrow.SetForwardVector(arrow.GetAbsVelocity())
					}
				}
			}
		// lastFireTime is defined here! LOOK AT IT
            lastFireTime = lastFireTimeNew;
			
	//Part 2 of 2
	//Every time we reload, we are slowed... wow
			if ( reloading )	//if we are reloading...
			{
				player.AddCustomAttribute("move speed penalty", 0.67, -1)	//Add attribute that reduces move speed.
			}
			else if ( !reloading )	//if -not- reloading...
			{
				player.RemoveCustomAttribute("move speed penalty")	//Remove move speed penalty.
			}
			
	// `return`!
			return // return to top after 0.1 delay
		}
// RUNS OUR THINK SCRIPT! Adds it to the entity, as long as it exists in the world.
		AddThinkToEnt(weapon, "think_SlowPlayerDuringReload")	//Adds the think script to handle 'weapon' after it has been validated.
	}
}

//-----------------------------------------------------------------------------
// The following function registers this weapon as "Medieval Crossbow".
// Use this in the console to give yourself this weapon in your own server:
//	script GetListenServerHost().GiveWeapon("Medieval Crossbow")
//-----------------------------------------------------------------------------
	RegisterCustomWeapon("Medieval Crossbow", "shotgun", null,
		Defaults|AnnounceToChat,
		function (table,player) {
		// Display Properties
		 // AnnounceToChat 
			table.name		= format("%s's Custom Crossbow",GTFW.GetNetName(player));	//Displays this when announcing the weapon in chat (aka "so-and-so has found: so-and-so's Crossbow"
			table.announce_quality	= "artisan";	//item color; see AnnounceWeapon() function for more info
			table.announce_prefix	= "";	//item prefix; can be string or number. The settings here remove it completely
			table.announce_has_string = "has crafted:"; //Fool everyone with "has crafted:" instead of the usual "has found:" line!

			table.worldModel = "models/workshop/weapons/c_models/c_crusaders_crossbow/c_crusaders_crossbow.mdl"
			
		// Ammo Properties
		 // Ammo Type
			table.ammoType		= TF_AMMO.PRIMARY;
			table.clipSize		= 3;		//Clipsize when weapon is equipped
			table.clipSizeMax	= 3;		//max clipsize can go
			table.reserve		= 27;		//reserve when ammo is equipped
			table.reserveMax	= 27;		//max reserve ammo can go
		},
		CW_Stats_Example_Scout_Medieval_Crossbow)
