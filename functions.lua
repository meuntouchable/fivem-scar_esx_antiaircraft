--//-----------------------------------------\\
--|| [SCAR] ESX Anti Aircraft
--|| meuntouchable#5555 (655378313514057759)
--|| https://scar-studios.tebex.io
--\\-----------------------------------------//

ESX=exports["es_extended"]:getSharedObject();


ScarAntiaircraft.Blips=function(x,y,z,name,color,size)
	local blip=AddBlipForCoord(x,y,z);
	
	SetBlipSprite(blip,270);
	SetBlipDisplay(blip,4);
	SetBlipScale(blip,size);
	SetBlipColour(blip,color);
	SetBlipAsShortRange(blip,true);
	BeginTextCommandSetBlipName("STRING");
	AddTextComponentString(name);
	EndTextCommandSetBlipName(blip);
	
	return blip;
end

ScarAntiaircraft.Areas=function(x,y,z,radius,color,alpha)
	local area=AddBlipForRadius(x,y,z,radius);
	
	SetBlipSprite(area,9);
	SetBlipDisplay(area,4);
	SetBlipColour(area,color);
	SetBlipAlpha(area,alpha);
	
	return area;
end


RegisterNetEvent("ScarAntiaircraft->ShowNotify")
AddEventHandler("ScarAntiaircraft->ShowNotify",function(text)
    BeginTextCommandThefeedPost('STRING');
    AddTextComponentSubstringPlayerName(text);
    EndTextCommandThefeedPostTicker(false,false);
end)




local ScarAntiaircraftPlayerJob=false;
local ScarAntiaircraftAllowed=false;

ScarAntiaircraft.CheckPerms=function(zone)
	local PlayerVehicle=GetVehiclePedIsIn(PlayerPedId(),false);
	
	ESX.TriggerServerCallback("ScarAntiaircraft->Callback->Job",function(data)
		for _,v in ipairs(ScarAntiaircraft.Zones[zone].Jobs)do
			if(data:find(v,1,false))then
				ScarAntiaircraftAllowed=true;
				return false;
			else
				ScarAntiaircraftAllowed=false;
			end
		end
	end)
end

ScarAntiaircraft.GetAllowed=function()
	return ScarAntiaircraftAllowed;
end

ScarAntiaircraft.Boom=function()
	local PlayerVehicle=GetVehiclePedIsIn(PlayerPedId(),false);
	
	SetVehicleEngineHealth(PlayerVehicle,50);
end