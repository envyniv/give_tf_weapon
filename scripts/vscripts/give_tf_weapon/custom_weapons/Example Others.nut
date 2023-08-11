//-----------------------------------------------------------------------------
// Other examples
// by Yaki
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
//	"tf_wearable" item
//	Uses blank item (IDX=65535) as base
//-----------------------------------------------------------------------------

	RegisterCustomWeapon("Sole Saviors", "tf_wearable", null, Defaults,
		function (table,player) {
			table.slot		 = 7; //This slot and up are considered body/passive. Make sure to update "Loadouts.nut" if you intend to use slots higher than this.
			table.worldModel = "models/workshop/player/items/all_class/sbox2014_armor_shoes/sbox2014_armor_shoes_demo.mdl";
		})
		
	
//-----------------------------------------------------------------------------
//	Makes building pretty darn quick.
//-----------------------------------------------------------------------------

	RegisterCustomWeapon("Engy Toolbox", "Toolbox", null, 0, null,
		function (weapon, player){
			player.GiveWeapon("Build PDA");
			player.GiveWeapon("Destroy PDA");
		})
	
//-----------------------------------------------------------------------------
//	Update model to shovel without changing stats. For MvM.
//-----------------------------------------------------------------------------

	RegisterCustomWeapon("Sandbox Shovel", "Bat",
		1123,
		KeepIDX|AutoSwitch|Save|AnnounceToChat,
		function (table,player) {
			table.classArms		= GTFW_ARMS.SOLDIER;
			table.worldModel	= "models/weapons/c_models/c_shovel/c_shovel.mdl";
		})
		
//-----------------------------------------------------------------------------
//	Override the backpack of Buff Banner with the Cold Case, an Engineer backpack.
//-----------------------------------------------------------------------------

	RegisterCustomWeapon("Booze Banner", "Buff",
		null,
		Defaults,
		function (table,player) {
			table.wearable	= "models/workshop/player/items/engineer/spr18_cold_case/spr18_cold_case.mdl";
		})

//-----------------------------------------------------------------------------
//	Testing Festive/Australium items
//	Only festive and the name "Australium" work here.
//-----------------------------------------------------------------------------

	RegisterCustomWeapon("australium", 14,
		null,
		Defaults,
		null,
		function (weapon,player) {
			weapon.AddAttribute("is australium item", 1, -1)	//gives australium name
			weapon.AddAttribute("item style override", 1, -1)
			weapon.AddAttribute("loot rarity", 1, -1)
			weapon.AddAttribute("is_festivized", 1, -1)			//adds festive lights to the weapon
		})
		
//-----------------------------------------------------------------------------
//	Making a primary weapon using secondary animations
//-----------------------------------------------------------------------------

	RegisterCustomWeapon("Secondary Anims in Primary Slot", "Revolver", "RL")


//-----------------------------------------------------------------------------
// End file. GTFW v5.1.0.
// Signed `Yaki`, 30 May 2023
//-----------------------------------------------------------------------------