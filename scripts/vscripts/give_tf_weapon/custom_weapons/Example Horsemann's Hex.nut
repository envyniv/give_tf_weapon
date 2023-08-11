//-----------------------------------------------------------------------------
// Example weapon #2. This one turns you into the Horseless Headless Horsemann.
// It is based off the Demo's Headtaker.
//-----------------------------------------------------------------------------
function CW_Stats_Example_Headless_Hatman(weapon, player)
{
// Setup
	player.SetCustomModelWithClassAnimations("models/player/demo.mdl")	//Needs to be here, else errors.
	NetProps.SetPropInt(player, "m_PlayerClass.m_iClass", 4)			//Forcefully sets tfclass to DEMOMAN
	player.RemoveCond(7)												//Removes taunting if was doing so previously
	
//Our stats
	weapon.AddAttribute("hidden maxhealth non buffed", (player.GetMaxHealth()*10) + 75, -1)	//using this attribute because it can't be overhealed
	player.SetHealth(player.GetMaxHealth())				//set health to max after given maxhealth bonus
	weapon.AddAttribute("move speed bonus", 1.25, -1)	//move speed up
	weapon.AddAttribute("damage bonus", 99, -1)			//instant death
	weapon.AddAttribute("melee range multiplier", 2, -1)//longer melee range
	weapon.AddAttribute("melee bounds multiplier", 2, -1)//larger melee range
	
	player.DeleteWeapon(TF_WEAPONSLOTS.SLOT0)		//deletes primary weapon
	player.DeleteWeapon(TF_WEAPONSLOTS.SLOT1)		//deletes secondary weapon
	player.DeleteWeapon(TF_WEAPONSLOTS.SLOT3)		//deletes anything else
	player.DeleteWeapon(TF_WEAPONSLOTS.SLOT4)		//deletes anything else
	player.DeleteWeapon(TF_WEAPONSLOTS.SLOT5)		//deletes anything else
	player.DeleteWeapon(TF_WEAPONSLOTS.SLOT6)		//deletes anything else
	
// Our effects
	player.SetForcedTauntCam(1)										//sets third person mode
	DoEntFire("!self", "SetModelScale", "1.3", 0, null, player)		//sets player scale
	Convars.SetValue("tf_item_based_forced_holiday", 2)				//Forces holiday to Halloween
	player.AddCustomAttribute("SPELL: set Halloween footstep type", 2, -1)	//enables Horseless Horseshoes spell walk flames
	player.AddCustomAttribute("set item tint RGB", 9109759, -1)				//sets tint for Horseless Horseshoes
	
// Deletes all cosmetics from the player
	local item = player.FirstMoveChild();
	for ( local i = 0; i < 21; i++ )	//21 is a random number; can be anything
	{
		printl("Starting...................")
		if ( item && item.IsValid() ) {
			
			printl(item.GetClassname())
			if ( item.GetClassname() == "tf_wearable" ) {
				item.Kill()
			}
			
			if ( item && item.IsValid() ) {
				item = item.NextMovePeer();	//defines next child parented to the player. Repeats
			}
		}
		else if ( item == null ) { break; }
	}
// Think script, used to remove stats from the player if the weapon disappears from loadout.
	if( weapon.ValidateScriptScope() )
	{
	// Define variables
		const HHHH_DELAY_THINK_STOP = 99999;
		const HHHH_DELAY_THINK = 1;
		local truefalse = true;
		local timeLeftBeforeTransformBack = 30;
		
		local weaponscope = weapon.GetScriptScope();
		weaponscope["think_HHHH_Maker"] <- function()	//Our script's name.
		{
	//Countdown for how long you last as the Horsemann
			timeLeftBeforeTransformBack = timeLeftBeforeTransformBack - 1;
			
	// Switches us to melee
			if ( truefalse ) {
				truefalse = false;
				player.Weapon_Switch(weapon);	//vscript built-in function. Forces switch to handle 'weapon'.
				player.AddCond(41);				//locks player in melee
		// return if this part runs
				return;							//'return' delay set to 0.1 by default
			}
			
	// If we unequip this weapon, force us the shapeshift back to Demoman.
			if ( player.GetActiveWeapon() != weapon		//If our weapon is not the HHHH...
			 || timeLeftBeforeTransformBack < 0 ) {		//... or if timer runs out
				player.SetForcedTauntCam(0);
				DoEntFire("!self", "SetModelScale", "1", 0, null, player);
				player.RemoveCustomAttribute("SPELL: set Halloween footstep type");
				player.RemoveCustomAttribute("set item tint RGB");
				player.DeleteLoadout("Horsemann's Hex")
				player.Regenerate(false);
				player.SetHealth(player.GetMaxHealth())
				return HHHH_DELAY_THINK_STOP;	//can't stop a think script within a think script, so we delay it into oblivion
			}
	// will the think script please return to top
			return HHHH_DELAY_THINK;	//'return' delay set to 0.1 by default
		}
		AddThinkToEnt(weapon, "think_HHHH_Maker");	//Adds the think script to handle 'weapon' after it has been validated.
	}
}

//-----------------------------------------------------------------------------
// Using an enum for define model paths
// Tip: You can use an enum like this to create shortcuts for strings
//-----------------------------------------------------------------------------
enum GTFW_MODELS_HHH
{
	BIGAXE		= "models/weapons/c_models/c_bigaxe/c_bigaxe.mdl",	//Horsemann's REAL Headtaker
	BIGMALLET	= "models/weapons/c_models/c_big_mallet/c_big_mallet.mdl", //Horsemann's Mallet
	HIMSELF		= "models/bots/headless_hatman.mdl", //HIMSELF
}

//-----------------------------------------------------------------------------
// Registers this weapon as "Horsemann's Hex"...
//-----------------------------------------------------------------------------

	RegisterCustomWeapon("Horsemann's Hex", "HHHH", null,
		Defaults+AnnounceToChat+WipeAttributes+ForceNotCustom,
		function (table,player) {
		// Display Properties
			table.name		= "The Horseless Headless Horsemann \x01is coming for you!";	//Displays this when announcing the weapon in chat
			table.announce_quality	= 5;							//item color; 5 = "Unusual" Quality purple; see AnnounceWeapon() function for more info
			table.announce_prefix	= "";						//item prefix; can be string or number. The settings here remove it completely
			table.announce_has_string = "\x05HAS TRANSFORMED...";
		
		// Model Properties
			table.classArms = GTFW_ARMS.DEMO;
			table.worldModel = GTFW_MODELS_HHH.BIGAXE;
			table.wearable	= GTFW_MODELS_HHH.HIMSELF;
		},
		CW_Stats_Example_Headless_Hatman)