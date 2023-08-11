# original give_tf_weapon by [Yakibomb](https://github.com/yakibomb)
#### for the changes, see [here](#changes)

## How Do I Use VScript?
	1) Watch this tutorial by TopHattWaffle on How to Use VScript:
		https://www.youtube.com/watch?v=p05bQ8ds8-w
	2) Come over to the TF2Maps Discord to ask questions, too! Beginners welcome.


## Setup ("Where do I put the files?")
	Make sure to place the folder give_tf_weapon and all containing files in directory `/tf/scripts/vscripts/`
	   It should look like `/tf/scripts/vscripts/give_tf_weapon/` with all the files in that directory.

## Before running give_tf_weapon script, be aware
	1. Please read "_master.nut" -- this script master script, responsible for default settings in this script.
		- "CVAR_GTFW_DEBUG_MODE" should be on when debugging custom weapons.
		- "ClearGameEventCallbacks()" should be noted/managed/deleted if not executing this script first.
		- Included script at the bottom
	2. Under "give_tf_weapon/custom_weapons/" in "_all.nut" -- Contains a list of all custom weapons that come with the script.
		- Add your custom weapons to the array after placing them in the "custom_weapons" folder.
	3. Under "give_tf_weapon/code/" in "__exec.nut" -- This nut is responsible for running all code scripts.
		- tried to document as much as I could. Ask me if you have any questions on it.

## Tutorials/references
	1. Please reference "HowToUse give_tf_weapon.nut" for examples on use of this script.
	2. Please reference "custom_weapons/tutorial/" in "CW_Tutorial #.nut" for more info on how to make custom weapons.
		- In the same folder, "reference gw_props.nut" can be referred to for properties you can set on weapons, that GiveWeapon() executes.


## To run this in your map	
	1. Then to execute this script in a map, make an entity with "vscripts" keyvalue, and place `give_tf_weapon/_master` as the parameter.
	2. Run the map, then it should automatically execute.

	3. Alternatively, you can test it in any map through console by typing `script_execute give_tf_weapon/_master`


## How to Give Yourself a Weapon (in console)
	1. After executing the script, you should be able to send out a console command to communicate with the script.
	2. Send this through the console:

		script GetListenServerHost().GiveWeapon("Weapon Here")

	3. It accepts any weapon names. Don't include "The" in the name--It won't accept that.
	4. It accepts item IDs, too.
	5. You can also give yourself the example custom weapons:

		script GetListenServerHost().GiveWeapon("Medieval Crossbow")
		script GetListenServerHost().GiveWeapon("Horsemann's Hex")
		script GetListenServerHost().GiveWeapon("Hottest Hand")
		script GetListenServerHost().GiveWeapon("Half-Life Shotgun")
		script GetListenServerHost().GiveWeapon("Shotgun Pickup")

### Notes:
	 - GetListenServerHost() is the person hosting the server.
	 - If you wanted to give another player a weapon, it must be a handle you make through the script.
	 - Use the `HowTo Use give_tf_weapon.nut` in the /give_tf_weapon/ folder for more examples on how to do this.


Have fun, modders!
Signed:
 - Yaki
 - 30 May 23

---
<a name=changes>
# give_tf_weapon - the envyn branch

## Changes
- Moved custom weapons to own repo, the scripts are to be included manually.
- Removed `_all.nut`, see above.

## Todo
- [ ] Add Weapon dropping functionality
		
