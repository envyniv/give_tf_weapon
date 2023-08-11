//-----------------------------------------------------------------------------
// Weapon Name: "Pickup Shotgun"
// Description: Crit-boosted.
//				This weapon doesn't replace another weapon, and deletes itself after switching away.
//				Can only hold 6 rounds, can't reload.
// Coded By:	Yaki
//-----------------------------------------------------------------------------

	RegisterCustomWeapon("Shotgun Pickup","shotgun",
		null,
		AutoSwitch|AnnounceToChat,
		function (table, player) {
			table.ammoType	= TF_AMMO.NONE;	// Makes it use ammo slot 0, not used by any other weapon
			table.reserve	= 6;
		},
		function (weapon,player) {
			
			weapon.AddAttribute("mod max primary clip override",-1,-1)	// Makes us use reserve ammo as clip ammo
			
			if( weapon.ValidateScriptScope() )
			{
				local JustHeld = true
				local weaponscope = weapon.GetScriptScope()
				weaponscope["think_pickup_shotgun"] <- function()
				{
			// Sets a delay here so we don't accidentally delete the weapon before we actually use it
					if ( JustHeld ) {
						JustHeld = false
						return 0.5
					}
			// While the shotgun is held out, give it full crits
					if ( weapon && player.GetActiveWeapon() == weapon ) {
						player.AddCondEx(38,0.11,null)
					}
					else { player.DeleteWeapon(weapon) }
					return
				}
				AddThinkToEnt(weapon, "think_pickup_shotgun")
			}
		})