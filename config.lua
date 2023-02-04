--//-----------------------------------------\\
--|| [SCAR] ESX Antiaircraft
--|| meuntouchable#5555 (655378313514057759)
--\\-----------------------------------------//

ScarAntiaircraft={};

ScarAntiaircraft.Notify=function(message)  --// SCAR Notify   https://github.com/meuntouchable/fivem-scar_notify
	--ESX.ShowNotification(message);   ESX example
	exports["scar_notify"]:ScarNotify(message,"info",true,5000);
end

ScarAntiaircraft.Zones={
	{--Zone 1
		Coords = {1715.63, 2594.42, 50,01},--X Y Z
		--Zone
		ZoneSize = 205.0,
		ZoneColor = 1,
		ZoneAlpha = 100,
		--Blip
		BlipSize = 0.9,
		BlipColor = 37,
		BlipName = "Prison",
		BlipEnabled = true,
		
		Jobs = {"police","ambulance"},--Whitelisted jobs
		
		Messages = {
            Warning = "Leave the area or the EMP System will be activated!",
            Activated = "EMP System activated!",
        },
	},
}