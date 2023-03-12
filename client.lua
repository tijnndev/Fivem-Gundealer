  
local PlayerData              = {}
ESX                           = nil
local xPlayer, job

Citizen.CreateThread(function ()
	while ESX == nil do
	  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	  Citizen.Wait(0)
	   PlayerData = ESX.GetPlayerData()
	end
  end)
  
  RegisterNetEvent('esx:playerLoaded')
  AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = ESX.GetPlayerData()
  end)
  
  RegisterNetEvent('esx:setJob')
  AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
  end)

function OpenMenu()
	local playerPed = PlayerPedId()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "wapendealer", {
		title = "Wapendealer",
		align = 'top-right',
		elements = {
			{label = "🔪>> Wapens", value = 'wapens'},
			{label = "📦>> Ammunitie", value = 'ammo'},
            {label = "🛠>> Tools", value = 'tools'},
			{label = "❌>> Sluiten", value = 'close'}
		}
	}, 
	function(data,menu)
	if data.current.value == 'wapens' then
			ESX.UI.Menu.CloseAll()
			OpenWapens()
		
    elseif data.current.value == 'ammo' then
		ESX.UI.Menu.CloseAll()
        OpenAmmo()

    elseif data.current.value == 'tools' then
		ESX.UI.Menu.CloseAll()
        OpenTools()
	elseif data.current.value == 'close' then
		ESX.UI.Menu.CloseAll()
end
end,
function()
	ESX.UI.Menu.CloseAll()
end)
end

function OpenAmmo()
	local playerPed = PlayerPedId()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "ammo", {
		title = "Ammo",
		align = 'top-right',
		elements = {
			{label = "🔫>> Pistol", value = 'pistol'},
			{label = "🔫>> SMG", value = 'smg'},
            {label = "🔫>> Shotgun", value = 'shotguns'},
			{label = "❌>> Terug naar main menu", value = 'mainmenu'}
		}
	}, 
	function(data,menu)
	if data.current.value == 'melee' then
		ESX.UI.Menu.CloseAll()
		OpenMelee()

	elseif data.current.value == 'hand' then
        ESX.UI.Menu.CloseAll()
		OpenMelee()

    elseif data.current.value == 'smgs' then
        ESX.UI.Menu.CloseAll()
		OpenMelee()

    elseif data.current.value == 'shotguns' then
        ESX.UI.Menu.CloseAll()
		OpenMelee()
    elseif data.current.value == 'mainmenu' then
		ESX.UI.Menu.CloseAll()
		OpenMenu()

end


end,
function()
	ESX.UI.Menu.CloseAll()
end)
end

function OpenWapens()
	local playerPed = PlayerPedId()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "Wapens", {
		title = "Wapens",
		align = 'top-right',
		elements = {
			{label = "🔪>> Steekwapens", value = 'melee'},
			{label = "👕>> Handwapens", value = 'hand'},
            {label = "🔫>> Automatische Wapens", value = 'smgs'},
			{label = "🔫>> Shotguns", value = 'shotguns'},
			{label = "❌>> Terug naar main menu", value = 'mainmenu'}
		}
	}, 
	function(data,menu)
	if data.current.value == 'melee' then
		ESX.UI.Menu.CloseAll()
		OpenMelee()

	elseif data.current.value == 'hand' then
        ESX.UI.Menu.CloseAll()
		OpenMelee()

    elseif data.current.value == 'smgs' then
        ESX.UI.Menu.CloseAll()
		OpenMelee()

    elseif data.current.value == 'shotguns' then
        ESX.UI.Menu.CloseAll()
		OpenMelee()
    elseif data.current.value == 'mainmenu' then
		ESX.UI.Menu.CloseAll()
		OpenMenu()
end
end,
function()
	ESX.UI.Menu.CloseAll()
end)
end

function OpenMelee()
	local playerPed = PlayerPedId()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "Wapens", {
		title = "Wapens",
		align = 'top-right',
		elements = {
			{label = "Boksbeugel", value = 'weapon_knuckle'},
			{label = "Hamer", value = 'weapon_hammer'},
			{label = "Knuppel", value = 'weapon_bat'},
			{label = "Knife", value = 'weapon_knife'},
			{label = "Switchblade", value = 'weapon_switchblade'},
			{label = "Machete", value = 'weapon_machete'},
			{label = "❌>> Terug naar main menu", value = 'mainmenu'}
		}
	}, 
	function(data,menu)
	if data.current.value then
		GiveWeaponToPed(PlayerPedId(), data.current.value, 1000, false, false)
	elseif data.current.value == 'mainmenu' then
		ESX.UI.Menu.CloseAll()
		OpenMenu()
	end


	end,
function()
	ESX.UI.Menu.CloseAll()
end)
end
function GiveWeapon(player, weapon)
	GiveWeaponToPed(player, "weapon_" + weapon, 1000, false, false)
end

local open = false

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlJustReleased(0, 322) and open or IsControlJustReleased(0, 177) and open then
			SendNUIMessage({
				action = "close"
			})
			open = false
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
			if IsControlJustReleased(0, 167) and PlayerData.job.name == 'wapendealer' then
				OpenMenu() 
		end
    end
end)

AddEventHandler('onResourceStop', function()
    SendNUIMessage({
        action = "close"
    })
    ESX.UI.Menu.CloseAll()
end)


