--//-----------------------------------------\\
--|| [SCAR] ESX Anti Aircraft
--|| meuntouchable#5555 (655378313514057759)
--|| https://scar-studios.tebex.io
--\\-----------------------------------------//

ESX=exports["es_extended"]:getSharedObject();


ESX.RegisterServerCallback("ScarAntiaircraft->Callback->Job",function(source,cb)
    local xPlayer=ESX.GetPlayerFromId(source);
	
	if(xPlayer)then
		cb(xPlayer.job.name);
	end
end)