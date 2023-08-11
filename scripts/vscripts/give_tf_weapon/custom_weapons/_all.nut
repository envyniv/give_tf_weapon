//-----------------------------------------------------------------------------
// Place all custom weapon files here.
// They are assembled at the bottom of the script with full file-path + extension name.
//-----------------------------------------------------------------------------

CW_File_List <- [
"Example CW_Tutorial",			//Tutorial Weapons
"Example Others",				//Various other examples

"Example Medieval Crossbow",	//All-class Crossbow, based off Shotgun
"Example Horsemann's Hex",		//Turns you into the Horsemann for 30 seconds
"Example Hottest Hand",			//Taunting shoots fireballs
"Example Half-Life Shotgun",	//Right-click fires a crit blast
"Example Shotgun Pickup",		//Hold a crit shotgun that expires after switching away
]


//-----------------------------------------------------------------------------
// Purpose: loop function
// grabs all the file names in the array an executes them
//-----------------------------------------------------------------------------
foreach ( weapon_file in CW_File_List )
{
	IncludeScript( "give_tf_weapon/custom_weapons/" + weapon_file + ".nut" );
}