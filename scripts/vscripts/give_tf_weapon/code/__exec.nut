GTFW_VScript <- Entities.FindByName(null, "vscript_give_tf_weapon_entity");

if ( GTFW_VScript == null ) {
	::TF_CUSTOM_WEAPONS_REGISTRY <- {};
	
	PrecacheModel("models/weapons/c_models/c_engineer_gunslinger.mdl");
	::worldspawn <- Entities.First();
	
	GTFW_VScript <- SpawnEntityFromTable("move_rope", {targetname = "vscript_give_tf_weapon_entity", vscripts="give_tf_weapon/_master.nut"});
	printl("Executing give_tf_weapon for the first time. Creating 'vscript_give_tf_weapon_entity' (ent: move_rope) entity.");
}

const GLOBAL_WEAPON_COUNT = 7


gtfw_exec_code <- [
//first batch necessary to run second batch
"_tables",
"_util",
"CreateCustomWearable()",
"GetWeaponTable()",
"SwitchToBest()",

//second batch
"GiveWeapon()",
"GetWeapon()",
"DeleteWeapon()",

//third batch
"AnnounceWeapon()",
"CustomWeaponRegistration",
"Loadouts",
"toggleWeaponByAmmo",

//end
"zz_BotFix"
]

foreach ( file in gtfw_exec_code )
{
	IncludeScript( "give_tf_weapon/code/" + file + ".nut" );
	printl( "g_tf_w Executing " + file )
}