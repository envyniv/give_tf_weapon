//-----------------------------------------------------------------------------
//	Purpose: Fixes bots using this script
//-----------------------------------------------------------------------------
::CTFBot.GiveWeapon <- CTFPlayer.GiveWeapon
::CTFBot.DeleteWeapon <- CTFPlayer.DeleteWeapon
::CTFBot.CreateCustomWearable <- CTFPlayer.CreateCustomWearable
::CTFBot.AnnounceWeapon <- CTFPlayer.AnnounceWeapon
::CTFBot.LoadLoadout <- CTFPlayer.LoadLoadout
::CTFBot.SaveLoadout <- CTFPlayer.SaveLoadout
::CTFBot.DeleteLoadout <- CTFPlayer.DeleteLoadout
::CTFBot.DisableWeapon <- CTFPlayer.DisableWeapon
::CTFBot.EnableWeapon <- CTFPlayer.EnableWeapon

::CTFBot.GTFW_Cleanup <- CTFPlayer.GTFW_Cleanup
::CTFBot.SwitchToBest <- CTFPlayer.SwitchToBest

::CTFBot.GetWeapon <- CTFPlayer.GetWeapon
::CTFBot.GetWeaponBySlot <- CTFPlayer.GetWeaponBySlot
::CTFBot.GetPassiveWeaponBySlot <- CTFPlayer.GetPassiveWeaponBySlot

::CTFBot.GetWeaponTable <- CTFPlayer.GetWeaponTable
::CTFBot.GetWeaponTableBySlot <- CTFPlayer.GetWeaponTableBySlot
::CTFBot.GetWeaponTableByClassname <- CTFPlayer.GetWeaponTableByClassname
::CTFBot.GetWeaponTableByString <- CTFPlayer.GetWeaponTableByString
::CTFBot.GetWeaponTableByID <- CTFPlayer.GetWeaponTableByID

::CTFBot.HasGunslinger <- CTFPlayer.HasGunslinger
::CTFBot.AddWeapon <- CTFPlayer.AddWeapon

//-----------------------------------------------------------------------------
//	Purpose: Renames in case someone else was using these function names before
//-----------------------------------------------------------------------------

//SwitchToBest
::CTFPlayer.SwitchToActive <- CTFPlayer.SwitchToBest
::CTFBot.SwitchToActive <- CTFPlayer.SwitchToBest

//GetWeapon
::CTFPlayer.ReturnWeapon <- CTFPlayer.GetWeapon
::CTFBot.ReturnWeapon <- CTFPlayer.GetWeapon

//GetWeaponBySlot
::CTFPlayer.ReturnWeaponBySlot <- CTFPlayer.GetWeaponBySlot
::CTFBot.ReturnWeaponBySlot <- CTFPlayer.GetWeaponBySlot

//GetWeaponTable
::CTFPlayer.ReturnWeaponTable <- CTFPlayer.GetWeaponTable
::CTFBot.ReturnWeaponTable <- CTFPlayer.GetWeaponTable

//Persist Loadout
::GTFW_DeleteAllLoadouts <- DeleteAllLoadouts
::CTFBot.GTFW_LoadLoadout <- CTFPlayer.LoadLoadout
::CTFBot.GTFW_SaveLoadout <- CTFPlayer.SaveLoadout
::CTFBot.GTFW_DeleteLoadout <- CTFPlayer.DeleteLoadout
::CTFPlayer.GTFW_LoadLoadout <- CTFPlayer.LoadLoadout
::CTFPlayer.GTFW_SaveLoadout <- CTFPlayer.SaveLoadout
::CTFPlayer.GTFW_DeleteLoadout <- CTFPlayer.DeleteLoadout