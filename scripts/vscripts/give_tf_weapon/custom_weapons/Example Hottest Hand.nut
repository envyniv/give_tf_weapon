//-----------------------------------------------------------------------------
// Weapon Name: "Hottest Hand"
// Description: A Hot Hand variant that lets you shoot fireballs by taunting!
//				Crit-boosted. Hadouken!
// Coded By:	Yaki
//-----------------------------------------------------------------------------

function CW_Stats_Example_Hottest_Hand(weapon, player)
{
	weapon.AddAttribute("special taunt", 1, -1) //Makes sure that Halloween holiday can't make us not use the taunt kill+fireball.
	
// Function to create a fireball, but only usable from within this script's scope
// Purpose: We use this to shoot the fireball after a delay in the taunt.
	CTFPlayer.ShootFireball <- function()
	{
	//Define variables.
		local hPlayer = this;	//Our player handle
		local fireball = SpawnEntityFromTable("tf_projectile_spellfireball", {
			origin = hPlayer.EyePosition()+(hPlayer.EyeAngles().Forward()*32) + Vector(0,0,hPlayer.EyeAngles().z-16),
			angles = hPlayer.EyeAngles(),
			teamnum = hPlayer.GetTeam(),
			basevelocity = hPlayer.EyeAngles().Forward()*800,
		})
		
		fireball.SetOwner(hPlayer);	//Sets the owner as the player
	}
	
// Purpose: Uses a think script to constantly check for when the Pyro 1) Has the HotHand out and 2) Is taunting.
//			Also gives 100% crits, only when this weapon is out!
	if( weapon.ValidateScriptScope() )	//You must ALWAYS validate before using ent.GetScriptScope()
	{
	//Define variables
		local wep;	//"local wep;" means "local wep = null;"
		local CAN_TAUNT_WITH_HOTHAND = false;
		local activeWeapon;	//"local activeWeapon;" means "local activeWeapon = null;"
		
	//Define scope. This is using the weapon's scope.
		local weaponscope = weapon.GetScriptScope()	//You must ALWAYS validate before using ent.GetScriptScope()
		weaponscope["think_PyroHottestHand"] <- function()	//Our script's name under the weapon scope.
		{
		// Defines variables in the weapon script
		// Defining this here means less stress on the game during processing time.
			activeWeapon = player.GetActiveWeapon()
	//Part 1 of 2
		//	To shoot the fireball, we need Hot Hand out and we need to taunt with it.
		//  (It might be easier to understand by reading the "else if" statement first!)
			if ( CAN_TAUNT_WITH_HOTHAND // if variable CAN_TAUNT_WITH_HOTHAND == true...
			 && player.InCond(7) ) {	// ... and if the player is taunting (InCond(7))
				CAN_TAUNT_WITH_HOTHAND = false;	//set CAN_TAUNT_WITH_HOTHAND to false;
				wep = null;						// set wep to null;
												// Doing this blocks access to running the next "else if" check, because "activeWeapon" does not equal "wep".
				
				DoEntFire("!self", "RunScriptCode", "self.ShootFireball()", 1.9, null, player);	//fire with 1.9 delay, with "self" being "player"
			}
		// "else if": When the first "if" criteria above isn't met, it'll try to run this "else if" statement instead.
			else if ( activeWeapon && activeWeapon.IsValid()	// if weapon exists and is IsValid()...
			 && activeWeapon != wep							// ... if active weapon does not equal "wep"...
			 && !player.InCond(7) )							// ... and if not taunting.
			{
				wep = activeWeapon;		// if player decides to switch weapons...
										//...make it so they don't run this "else if" again!
				
				if ( wep.GetClassname() == "tf_weapon_slap" )	//Checks if player is holding the Hot Hand... and if true...
					CAN_TAUNT_WITH_HOTHAND = true;			// ... allows us to shoot a fireball during a taunt!
			}
			
	// Part 2 of 2
		// We'll give this weapon 100% crits for fun!!
		// If the player is holding the Hot Hand out, add crits. Otherwise, remove 'em.
			if ( activeWeapon && activeWeapon.IsValid()				//If the active weapon exists and IsValid()...
			 && activeWeapon.GetClassname() == "tf_weapon_slap" )	//... if the player's active weapon is the Hot Hand...
				player.AddCondEx(37, 0.15, player);					// Apply First-Blood Arena crit-boost!
																	// Constantly applies so if the player every loop, incase the weapon ever stops existing.
			else	//if those statements do not pass, (or simply not using Hot Hand)
				player.RemoveCond(37);	//remove First-Blood arena crits
			return	//uses default 0.1 delay
		}
		AddThinkToEnt(weapon, "think_PyroHottestHand")	//After all that's said an done, this adds the think script to handle 'weapon' after it has been validated.
	}
}
//-----------------------------------------------------------------------------
// Finally, we register the weapon for us to use with GiveWeapon()!
//-----------------------------------------------------------------------------
	RegisterCustomWeapon(
		"Hottest Hand",				//Name of our weapon for GiveWeapon() to take
		"Hot Hand",					//the weapon we are basing this one off of
		null,						//An override item definition index; this would normally change the animations/model of the weapon
		Defaults+AnnounceToChat,	//Spawn flags for GiveWeapon()
		function (table,player){ 	//function that holds a lot of properties before spawning the weapon
			table.worldModel	= "models/empty.mdl";	//removes Hot Hand glove model
			table.classArms = GTFW_ARMS.PYRO;		//Adds Pyro arms model to all classes
		},
		CW_Stats_Example_Hottest_Hand)	// our stats for the weapon.