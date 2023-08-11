//-----------------------------------------------------------------------------
// The following is a tutorial.
// We are adding attributes now!
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
//	-> Let's say I think the animations for stock look weird.
// I want the animations be all-class melee.
// So let's update that!
//-----------------------------------------------------------------------------

	RegisterCustomWeapon("Basic Sword", "sword",
		1123,
		Defaults|WipeAttributes,
		function (table, player) {
			table.worldModel = "models/workshop/weapons/c_models/c_scout_sword/c_scout_sword.mdl";
		})
		
//-----------------------------------------------------------------------------
//	-> Parameter 1 ("Basic Sword") hasn't changed.
//	-> Parameter 2 ("sword") hasn't changed.
//	-> Parameter 3 (1123) enables all-class animations (IDX = Necro Smasher).
//	-> Parameter 4 (Defaults|WipeAttributes) hasn't changed.
//	-> Parameter 5 updates the world model to the Three-Rune Blade.
//-----------------------------------------------------------------------------
// On Parameter 5: A function which adds more properties to the weapon in GiveWeapon(). Full list in "reference gw_props.nut"
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
//	-> Let's add some new stats to our sword.
//-----------------------------------------------------------------------------
// The stats function is executed after the weapon spawns.
// It holds any stat buffs/nerfs/any code you want to inject into the weapon.
// It has two handles you can use: The weapon, and the player.
//-----------------------------------------------------------------------------

function CW_Stats_Example_Basic_Sword(weapon, player) //The name of your function that calls stats, as well as the handles for our weapon and the player equipping the weapon.
{
// Here are our stats on the weapon. A full list of attributes found on the Official TF2Wiki. https://wiki.teamfortress.com/wiki/Attributes
	weapon.AddAttribute("damage bonus", 1.09, -1)				//increases our damage by 9%. (percentage; from 100%)
	weapon.AddAttribute("max health additive penalty", -17, -1)	//reduces our health by 17. (additive; from base health)
	weapon.AddAttribute("move speed penalty", 1.33, -1)			//increases speed by 33% (percentage; from 100%)
}

//-----------------------------------------------------------------------------
// ... now let's apply it to the weapon.
//-----------------------------------------------------------------------------

	RegisterCustomWeapon("Basic Sword", "sword",
		1123,
		Defaults|WipeAttributes,
		function (table, player) {
			table.worldModel = "models/workshop/weapons/c_models/c_scout_sword/c_scout_sword.mdl";
		},
		CW_Stats_Example_Basic_Sword)

//-----------------------------------------------------------------------------
//	-> Parameter 1 through Parameter 5 haven't changed.
//	-> Parameter 6 (CW_Stats_Example_Basic_Sword) is the name of the function we are using.
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
// You can give yourself this weapon in your game server. To execute the script, run:
//  script_execute give_tf_weapon/_master
// Then you may type the following in the console to give yourself the weapon:
//  script GetListenServerHost().GiveWeapon("Fully Custom Sword")
//-----------------------------------------------------------------------------
// That's it! You've finished the tutorial series!
//-----------------------------------------------------------------------------