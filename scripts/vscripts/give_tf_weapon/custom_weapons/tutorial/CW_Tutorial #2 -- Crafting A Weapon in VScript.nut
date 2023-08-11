//-----------------------------------------------------------------------------
// The following is a tutorial.
// Now that we know the function RegisterCustomWeapon(), let's use it!
// We'll make our first weapon!!
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
//	-> First let's register a custom weapon.
// Let try... a Stock knife named "Example Knife".
//-----------------------------------------------------------------------------
	
	RegisterCustomWeapon("Example Knife", "Knife")
	
//-----------------------------------------------------------------------------
//	-> Parameter 1 ("Example Knife") is the name of the custom weapon. When searching for the weapon (using GiveWeapon(), GetWeapon(), etc), we can find it by this name.
//	-> Parameter 2 ("Knife") is the name of the weapon we're basing it off of.
//-----------------------------------------------------------------------------
//	To the player, it is a carbon copy of the stock Knife.
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
//	-> Hmm... I want to make a sword instead. Let's make a new weapon called "Basic Sword", and make it use the Eyelander's classname--"tf_weapon_sword".
//-----------------------------------------------------------------------------

	RegisterCustomWeapon("Basic Sword", "sword")
		
//-----------------------------------------------------------------------------
//	-> Parameter 1 ("Basic Sword") is the name of a new custom weapon.
//	-> Parameter 2 ("sword") is shorthand for the classname "tf_weapon_sword"
//-----------------------------------------------------------------------------
//	Right now, it just looks like the Eyelander, and the animations are broken on all classes outside Demo.
//	Let's change that.
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
//	-> Let's introduce the Item Definition Index override parameter.
//	It's Parameter 3, and what it does is makes our weapon grab the attributes, models, animations, and other statistics from items_game.txt.
//	More on that soon.
//-----------------------------------------------------------------------------

	RegisterCustomWeapon("Basic Sword", "sword",
		452)
		
//-----------------------------------------------------------------------------
//	-> Parameter 1 ("Basic Sword") hasn't changed.
//	-> Parameter 2 ("sword") hasn't changed.
//	-> Parameter 3 (452) is an Item Definition Index override, set to the Three-Rune Blade (Boston Basher reskin).
//-----------------------------------------------------------------------------
// On Parameter 3: Item Definition Index (or IDX for short) is an ID used by all items in TF2. Each IDX is unique, between 0 to 65535.
// These IDXs are designated per item in items_game.txt. In that same file, it lists all attributes, weapon models, and other statistics per item.
//-----------------------------------------------------------------------------
// So now, we have changed the animations to stock, and made the weapon look like the Three-Rune Blade.
// However, now the item itself uses the Boston Basher's attributes!
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
//	-> Let's remove them, shall we?
//-----------------------------------------------------------------------------

	RegisterCustomWeapon("Basic Sword", "sword",
		452,
		Defaults|WipeAttributes)
		
//-----------------------------------------------------------------------------
//	-> Parameter 1 ("Basic Sword") hasn't changed.
//	-> Parameter 2 ("sword") hasn't changed.
//	-> Parameter 3 (452) hasn't changed.
//	-> Parameter 4 (Defaults|WipeAttributes) are the gw_props. It sets `Defaults` and `WipeAttributes` bits on this weapon.
//-----------------------------------------------------------------------------
// On Parameter 4: gw_props (or GiveWeapon Properties) is used by give_tf_weapon to add additional properties when being processed by GiveWeapon().
// You might've seen the keyvalue `effects` in a lot of Source entities. `effects` uses bits to set a bunch of different properties inside a single number.
// gw_props uses the same technique, holding a lot of different properties in one number.
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
//	-> As of GTFW v5.0.0, there are 9 properties on the list.
// They are as follows:
//-----------------------------------------------------------------------------

	DeleteAndReplace	// Deletes weapon that matches the slot of the new weapon, /then/ adds the new weapon. Not compatible with KeepIDX bit.
	KeepIDX 			// Only updates the Item Definition Index of the given weapon. Not compatible with DeleteAndReplace bit.
	AutoSwitch 			// Forcefully switches to the weapon if obtained.
	WipeAttributes 		// Clears original attributes present on the weapon.
	ForceCustom			// Forces the weapon to be custom (which means netprop "ItemIDHigh" bit 6 set)
	ForceNotCustom		//  Makes sure to remove flags that make a weapon custom.
	AnnounceToChat		// Announces the weapon in chat for all to see what you got!
	Save				// Saves the weapon, allowing players to retrieve it as long as function "handle.LoadLoadout()" is used.
	AutoRegister 		// Automatically registers the weapon if it hasn't been already registered. Use with caution!

	Defaults 			// This is set in _master.nut. Defaults are set to, by default, DeleteAndReplace|AutoSwitch|Save


//-----------------------------------------------------------------------------
// You can give yourself this weapon in your game server! To execute give_tf_weapon in console, run:
//  script_execute give_tf_weapon/_master
// Then you may type the following in console to give yourself the weapon:
//  script GetListenServerHost().GiveWeapon("Basic Sword")
//-----------------------------------------------------------------------------
// That's it! You've finished tutorial #2!
//-----------------------------------------------------------------------------