
//-----------------------------------------------------------------------------
// Purpose: Announces a weapon in chat for all players to see!
//-----------------------------------------------------------------------------

::CTFPlayer.AnnounceWeapon <- function(weapon,quality=null,prefix=null,has_string="has found:",player_prefix=null) {	
	
// Purpose: Defining player
	local player = this;
	
// Purpose: Finds weapon in `tables.nut`
	local wep = player.ReturnWeaponTable(weapon);	//Convert our weapon into a table with additional information about the weapon
	if ( wep == null ) {
		GTFW.DevPrint(1,"AnnounceWeapon", "Function failed. Could not find \x22"+weapon+"\x22. Returning null.");
		return null;
	}
	
// Purpose: Fixing the space if player prefix is set
	local space_player_prefix = "";
	if ( player_prefix && type ( player_prefix ) == "string" && !prefix.find("\x0") ) space_player_prefix = " ";
	
// Purpose: Defining variables
	if ( type ( quality ) != "string" && type( quality ) != "integer" ) quality = -1;
	if ( type ( prefix ) != "string" && type( prefix ) != "integer" ) prefix = quality;
	if ( type ( has_string ) != "string" && type( has_string ) != "integer" ) has_string = "has found:";
	if ( type( player_prefix ) != "string" && type( player_prefix ) != "integer" ) player_prefix = "";
	
	
	
// Purpose: Defining text colors
// Here we are making the player's color change, based on their team
	local teamTextColor = null
	switch ( player.GetTeam() ) {
		case 2 : teamTextColor = "\x07FF3F3F"; break;	//RED
		case 3 : teamTextColor = "\x0799CDFF"; break;	//BLU
		case 5 : teamTextColor = "\x05"; break;			//Merasmus/Skeleton King/green
		default : teamTextColor = "\x07B2B2B2"; break; 	//spectator/unassigned/gray
	}

// Changing the prefix for the quality item.
// If the prefix is null, make the prefix = quality
// It can be a string of your choosing, too.
	if ( type( prefix ) == "integer" ) {
		switch ( prefix ) {
			case 0 : {prefix = ""; break; }				//	stock
			case 1 : {prefix = "The"; break; }			//	Unique
			case 2 : {prefix = "Vintage"; break; }		//	Vintage
			case 3 : {prefix = "Genuine"; break; }		//	Genuine
			case 4 : {prefix = "Strange"; break; }		//	Strange
			case 5 : {prefix = "Unusual"; break; }		//	Unusual
			case 6 : {prefix = "Haunted"; break; }		//	Haunted
			case 7 : {prefix = "Collector's"; break; }	//	Collector's
			case 8 : {prefix = "Decorated"; break; }		//	Decorated
			case 9 : {prefix = "Community"; break; }		//	Community
			case 10 : {prefix = "Self-Made"; break; }		//	Self-Made
			case 11 : {prefix = "Valve"; break; }			//	Valve
			
			case 18 : {prefix = "Well-Designed"; break; }	//	Well-Designed (unused)
			case 19 : {prefix = "Artisan"; break; }			//	Artisan (unused)
			
			case 20 : {prefix = "Australium"; break; }		//	Australium
			
			default : {prefix = "Custom"; break; }
		}
	}

//All the unique color codes for items. Phew!
// Uses integers OR strings
	if ( type( quality ) == "integer" ) {
		switch ( quality ) {
			case 0 : {quality = "\x07B2B2B2"; break; }	//	stock
			case 1 : {quality = "\x07FFD700"; break; }	//	Unique
			case 2 : {quality = "\x07476291"; break; }	//	Vintage
			case 3 : {quality = "\x074D7455"; break; }	//	Genuine
			case 4 : {quality = "\x07CF6A32"; break; }	//	Strange
			case 5 : {quality = "\x078650AC"; break; }	//	Unusual
			case 6 : {quality = "\x0738F3AB"; break; }	//	Haunted
			case 7 : {quality = "\x07AA0000"; break; }	//	Collector's
			case 8 : {quality = "\x07FAFAFA"; break; }	//	Decorated
			case 9 : {quality = "\x0770B04A"; break; }	//	Community
			case 10 : {quality = "\x0770B04A"; break; }	//	Self-Made
			case 11 : {quality = "\x07A50F79"; break; }	//	Valve
			
			case 12 : {quality = "\x07B0C3D9"; break; }	//	Civilian Grade
			case 13 : {quality = "\x075E98D9"; break; }	//	Freelance Grade
			case 14 : {quality = "\x074B69FF"; break; }	//	Mercenary Grade
			case 15 : {quality = "\x078847FF"; break; }	//	Commando Grade
			case 16 : {quality = "\x07D32CE6"; break; }	//	Assassin Grade 
			case 17 : {quality = "\x07EB4B4B"; break; }	//	Elite Grade
			
			case 18 : {quality = "\x078D834B"; break; }	//	Well-Designed (unused)
			case 19 : {quality = "\x0770550F"; break; }	//	Artisan (unused)
			
			case 20 : {quality = "\x07CF6A32"; break; }	//	Australium
			
			default : {quality = "\x03"; break; }		//	VScript. Custom.
		}
	}
	else if ( type( quality ) == "string" ) {
		
		local quality_toupper = quality.toupper()
		
		switch ( quality_toupper ) {
			case "UNIQUE"		: {quality = "\x07B2B2B2"; break; }	//	Unique
			case "VINTAGE"		: {quality = "\x07476291"; break; }	//	Vintage
			case "GENUINE"		: {quality = "\x074D7455"; break; }	//	Genuine
			case "STRANGE"		: {quality = "\x07CF6A32"; break; }	//	Strange
			case "UNUSUAL"		: {quality = "\x078650AC"; break; }	//	Unusual
			case "HAUNTED"		: {quality = "\x0738F3AB"; break; }	//	Haunted
			case "COLLECTOR'S"	: {quality = "\x07AA0000"; break; }	//	Collector's
			case "DECORATED"	: {quality = "\x07FAFAFA"; break; }	//	Decorated
			case "COMMUNITY"	: {quality = "\x0770B04A"; break; }	//	Community
			case "SELF-MADE"	: {quality = "\x0770B04A"; break; }	//	Self-Made
			case "VALVE"		: {quality = "\x07A50F79"; break; }	//	Valve
			
			case "CIVILIAN"		: {quality = "\x07B0C3D9"; break; }	//	Civilian Grade
			case "FREELANCE"	: {quality = "\x075E98D9"; break; }	//	Freelance Grade
			case "MERCENARY"	: {quality = "\x074B69FF"; break; }	//	Mercenary Grade
			case "COMMANDO"		: {quality = "\x078847FF"; break; }	//	Commando Grade
			case "ASSASSIN"		: {quality = "\x07D32CE6"; break; }	//	Assassin Grade 
			case "ELITE"		: {quality = "\x07EB4B4B"; break; }	//	Elite Grade
			
			case "WELL-DESIGNED" : {quality = "\x078D834B"; break; } //	Well-Designed (unused)
			case "ARTISAN"		 : {quality = "\x0770550F"; break; } //	Artisan (unused)
			
			case "AUSTRALIUM" 	: {quality = "\x07CF6A32"; break; }	//	Australium; copy of Strange
			
			case "CUSTOM" : {quality = "\x03"; break; }	//	VScript. Custom.
		}
	}
	
//Finishing touches

	// Purpose: Adds spaces in the final string
	local space_prefix = ""
	if ( prefix && type ( prefix ) == "string" && prefix.len() && !prefix.find("\x0") ) space_prefix = " "
	
	//format player display name
	local playerNetName = GetPropString(player, "m_szNetname")	//Client's Steam name
	local player_display = format("%s%s%s%s",player_prefix,space_player_prefix,teamTextColor,playerNetName)
	
	//format item name
	local weapon_display = format("%s%s%s%s", quality, prefix, space_prefix, wep.name)
	
//Voila! Text is displayed for all players!
	local voila = format("\x01%s \x01%s %s",player_display,has_string,weapon_display)
	ClientPrint(null,3,voila)
	
	GTFW.DevPrint(0,"AnnounceWeapon", voila)
	
}