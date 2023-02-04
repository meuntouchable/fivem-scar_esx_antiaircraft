--//-----------------------------------------\\
--|| [SCAR] ESX Anti Aircraft
--|| meuntouchable#5555 (655378313514057759)
--|| https://scar-studios.tebex.io
--\\-----------------------------------------//

ESX=exports["es_extended"]:getSharedObject();


local ScarAntiaircraftInside=nil;
local ScarAntiaircraftPerms=nil;
local ScarAntiaircraftWarn=0;


CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Wait(0);
	end
	
	for i=1,#ScarAntiaircraft.Zones,1 do
		if(ScarAntiaircraft.Zones[i].BlipEnabled and ScarAntiaircraft.Zones[i].BlipEnabled==true)then
			ScarAntiaircraft.Blips(ScarAntiaircraft.Zones[i].Coords[1],ScarAntiaircraft.Zones[i].Coords[2],ScarAntiaircraft.Zones[i].Coords[3],ScarAntiaircraft.Zones[i].BlipName,ScarAntiaircraft.Zones[i].BlipColor,ScarAntiaircraft.Zones[i].BlipSize);
		end
		ScarAntiaircraft.Areas(ScarAntiaircraft.Zones[i].Coords[1],ScarAntiaircraft.Zones[i].Coords[2],ScarAntiaircraft.Zones[i].Coords[3],ScarAntiaircraft.Zones[i].ZoneSize,ScarAntiaircraft.Zones[i].ZoneColor,ScarAntiaircraft.Zones[i].ZoneAlpha);
	end
	Wait(5*1000);
end)

CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Wait(0);
	end
	
	while true do
		local x,y,z=table.unpack(GetEntityCoords(GetPlayerPed(-1),true));
		local minDistance=20000;
		for i=1,#ScarAntiaircraft.Zones,1 do
			dist=Vdist(ScarAntiaircraft.Zones[i].Coords[1],ScarAntiaircraft.Zones[i].Coords[2],ScarAntiaircraft.Zones[i].Coords[3],x,y,z);
			if(dist<minDistance)then
				minDistance=dist;
				closestZone=i;
			end
		end
		Wait(2*1000);
	end
end)


CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId())do
		Wait(0);
	end
	
	while true do
		local x,y,z=table.unpack(GetEntityCoords(GetPlayerPed(-1),true));
		local dist=Vdist(ScarAntiaircraft.Zones[closestZone].Coords[1],ScarAntiaircraft.Zones[closestZone].Coords[2],ScarAntiaircraft.Zones[closestZone].Coords[3],x,y,z);
		local PlayerVehicle=GetVehiclePedIsIn(PlayerPedId(),false);
		
		if(GetPedInVehicleSeat(PlayerVehicle,-1)==GetPlayerPed(-1))then
			if(DoesEntityExist(PlayerVehicle)and not IsEntityDead(GetPlayerPed(-1)))then
				if(dist<=ScarAntiaircraft.Zones[closestZone].ZoneSize*1)then
					local PlayerVehicleModel=GetEntityModel(PlayerVehicle);
					
					if(IsThisModelAHeli(PlayerVehicleModel)or IsThisModelAPlane(PlayerVehicleModel))then
						ScarAntiaircraftInside=true;
						
						ScarAntiaircraft.CheckPerms(closestZone);Wait(100);
						
						if(ScarAntiaircraftInside)then
							if(ScarAntiaircraft.GetAllowed()==false)then
								if(ScarAntiaircraftWarn<=3)then
									ScarAntiaircraftWarn=ScarAntiaircraftWarn+1;
									
									if(ScarAntiaircraftWarn==1)then
										ScarAntiaircraft.Notify(ScarAntiaircraft.Zones[closestZone].Messages.Warning);
									elseif(ScarAntiaircraftWarn==3)then
										ScarAntiaircraft.Notify(ScarAntiaircraft.Zones[closestZone].Messages.Activated);
									end
									
									if(ScarAntiaircraftWarn==4)then
										ScarAntiaircraft.Boom();
									end
								elseif(ScarAntiaircraftWarn>=4)then
									ScarAntiaircraft.Boom();
								end
							else
								ScarAntiaircraftWarn=0;
							end
						end
						
					end
					Wait(1100);
				else
					ScarAntiaircraftInside=nil;
					ScarAntiaircraftWarn=0;
					Wait(300);
				end
			end
		end
		Wait(100);
	end
end)