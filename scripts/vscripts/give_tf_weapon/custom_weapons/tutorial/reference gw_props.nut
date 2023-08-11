
//-----------------------------------------------------------------------------
// Parameter 5 adds additional properties to the weapon, set by the function GiveWeapon().
//-----------------------------------------------------------------------------
// Here is a whole list of usable properties that can be used in this function.
// If you don't need to use the property, you don't need to put it on the list.
//-----------------------------------------------------------------------------

	// Display Properties
		table.name				  = "Fully Custom Sword";	//Displays this when announcing the weapon in chat (aka "so-and-so has found: The Fully Custom Sword")
		table.announce_quality	  = "unique";				//item color; "Unique" = yellow text color; see AnnounceWeapon() function for more info
		table.announce_prefix	  = "My";					//item prefix; can be string or number. This changes "The" from Unique quality to "My".
		table.announce_has_string = "has found:";			//Default is "has found:"
	// Stat Properties
		table.tf_class		= 0;		// Class the weapon would usually be held by. 0 = all-class. Doesn't really need to be set.
		table.slot			= 0;		// The slot the script checks for before deleting and making our new weapon
	// Ammo Properties
	 // Note: Default is -1. If Default set, uses base weapon's properties.
		table.ammoType		= -1;		//Which ammo pool the weapon draws from; use enum TF_AMMO in tables for valid ammotypes
		table.clipSize		= -1;		//Clipsize the weapon starts with
		table.clipSizeMax	= -1;		//Clipsize cap the weapon has
		table.reserve		= -1;		//reserve ammo the weapon starts with
		table.reserveMax 	= -1;		//max reserve ammo can go
	// Model Properties
		table.classArms		= null;		// viewmodel class arms animations the weapon uses
		table.worldModel	= null;		// The weapon others see in on us; if not set and viewModel is, the script updates this prop to use viewModel's model
		table.viewModel		= null;		// The weapon we see in first-person; if not set and worldModel is, the script updates this prop to use worldModel's model
		table.wearable		= null;		// Extra wearable, like the Buff Banner's backpack, etc. If using "tf_wearable" as base, use worldModel instead.
		table.wearable_vm	= null;		// Extra wearable for viewmodel, like botkiller weapons' bot head.

