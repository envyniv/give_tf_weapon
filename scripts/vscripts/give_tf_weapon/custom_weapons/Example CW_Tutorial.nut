//Check "tutorial" folder in same directory as this file!

/*
	Weapons to try:
	
	"Example Knife"
	"Basic Sword"
	"Better Sword"
	"Fully Custom Sword"

*/

	RegisterCustomWeapon("Example Knife", "Knife")
	
	RegisterCustomWeapon("Basic Sword", "sword",
		452,
		Defaults|WipeAttributes)

	RegisterCustomWeapon("Better Sword", "sword",
		1123,
		Defaults|WipeAttributes,
		function (table, player) {
			table.worldModel = "models/workshop/weapons/c_models/c_scout_sword/c_scout_sword.mdl";
		})


function CW_Stats_Example_Basic_Sword(weapon, player)
{
	weapon.AddAttribute("damage bonus", 1.09, -1)
	weapon.AddAttribute("max health additive penalty", -17, -1)
	weapon.AddAttribute("move speed penalty", 1.33, -1)
}

	RegisterCustomWeapon("Fully Custom Sword", "sword",
		1123,
		Defaults|WipeAttributes,
		function (table, player) {
			table.worldModel = "models/workshop/weapons/c_models/c_scout_sword/c_scout_sword.mdl";
		},
		CW_Stats_Example_Basic_Sword)

