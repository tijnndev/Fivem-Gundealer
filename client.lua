local PlayerData = {}
ESX = nil
local xPlayer, job

Citizen.CreateThread(
	function()
		while ESX == nil do
			TriggerEvent(
				"esx:getSharedObject",
				function(obj)
					ESX = obj
				end
			)
			Citizen.Wait(0)
			PlayerData = ESX.GetPlayerData()
		end
	end
)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler(
	"esx:playerLoaded",
	function(xPlayer)
		PlayerData = ESX.GetPlayerData()
	end
)

RegisterNetEvent("esx:setJob")
AddEventHandler(
	"esx:setJob",
	function(job)
		PlayerData.job = job
	end
)

function OpenMenu()
	local playerPed = PlayerPedId()
	ESX.UI.Menu.Open(
		"default",
		GetCurrentResourceName(),
		"wapendealer",
		{
			title = "Wapendealer",
			align = "top-right",
			elements = {
				{label = "🔪>> Wapens", value = "wapens"},
				{label = "📦>> Ammunitie", value = "ammo"},
				{label = "❌>> Sluiten", value = "close"}
			}
		},
		function(data, menu)
			if data.current.value == "wapens" then
				ESX.UI.Menu.CloseAll()
				OpenWapens()
			elseif data.current.value == "ammo" then
				ESX.UI.Menu.CloseAll()
				OpenAmmo()
			elseif data.current.value == "close" then
				ESX.UI.Menu.CloseAll()
			end
		end,
		function()
			ESX.UI.Menu.CloseAll()
		end
	)
end

function OpenAmmo()
	local playerPed = PlayerPedId()
	ESX.UI.Menu.Open(
		"default",
		GetCurrentResourceName(),
		"ammo",
		{
			title = "Ammo",
			align = "top-right",
			elements = {
				{label = _U("ammo-pistol"), value = "pistol"},
				{label = _U("ammo-pistol"), value = "smg"},
				{label = _U("ammo-pistol"), value = "shotguns"},
				{label = _U("back"), value = "mainmenu"}
			}
		},
		function(data, menu)
			local PlayerId = PlayerPedId()
			if data.current.value == "pistol" then
				TriggerServerEvent("GiveItem", PlayerId, itemName, 50)
			elseif data.current.value == "smg" then
				TriggerServerEvent("GiveItem", PlayerId, itemName, 50)
			elseif data.current.value == "shotguns" then
				TriggerServerEvent("GiveItem", PlayerId, itemName, 25)
			elseif data.current.value == "mainmenu" then
				ESX.UI.Menu.CloseAll()
				OpenMenu()
			end
		end,
		function()
			ESX.UI.Menu.CloseAll()
		end
	)
end

function OpenWapens()
	local playerPed = PlayerPedId()
	ESX.UI.Menu.Open(
		"default",
		GetCurrentResourceName(),
		"Wapens",
		{
			title = "Wapens",
			align = "top-right",
			elements = {
				{label = _U("melee"), value = "melee"},
				{label = _U("pistols"), value = "hand"},
				{label = _U("smgs"), value = "smgs"},
				{label = _U("shotguns"), value = "shotguns"},
				{label = _U("back"), value = "mainmenu"}
			}
		},
		function(data, menu)
			if data.current.value == "melee" then
				ESX.UI.Menu.CloseAll()
				OpenMelee()
			elseif data.current.value == "hand" then
				ESX.UI.Menu.CloseAll()
				OpenMelee()
			elseif data.current.value == "smgs" then
				ESX.UI.Menu.CloseAll()
				OpenMelee()
			elseif data.current.value == "shotguns" then
				ESX.UI.Menu.CloseAll()
				OpenMelee()
			elseif data.current.value == "mainmenu" then
				ESX.UI.Menu.CloseAll()
				OpenMenu()
			end
		end,
		function()
			ESX.UI.Menu.CloseAll()
		end
	)
end

function OpenMelee()
	local playerPed = PlayerPedId()
	ESX.UI.Menu.Open(
		"default",
		GetCurrentResourceName(),
		"Wapens",
		{
			title = "Wapens",
			align = "top-right",
			elements = {
				{label = _U("knuckle"), value = "weapon_knuckle"},
				{label = _U("hammer"), value = "weapon_hammer"},
				{label = _U("bat"), value = "weapon_bat"},
				{label = _U("knife"), value = "weapon_knife"},
				{label = _U("switchblade"), value = "weapon_switchblade"},
				{label = _U("machete"), value = "weapon_machete"},
				{label = _U("back"), value = "mainmenu"}
			}
		},
		function(data, menu)
			if data.current.value then
				GiveWeaponToPed(PlayerPedId(), data.current.value, 1000, false, false)
			elseif data.current.value == "mainmenu" then
				ESX.UI.Menu.CloseAll()
				OpenMenu()
			end
		end,
		function()
			ESX.UI.Menu.CloseAll()
		end
	)
end
function GiveWeapon(player, weapon)
	GiveWeaponToPed(player, "weapon_" + weapon, 1000, false, false)
end

local open = false

Citizen.CreateThread(
	function()
		while true do
			Wait(0)
			if IsControlJustReleased(0, 322) and open or IsControlJustReleased(0, 177) and open then
				SendNUIMessage(
					{
						action = "close"
					}
				)
				open = false
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if IsControlJustReleased(0, 167) and PlayerData.job.name == "wapendealer" then
				OpenMenu()
			end
		end
	end
)

AddEventHandler(
	"onResourceStop",
	function()
		SendNUIMessage(
			{
				action = "close"
			}
		)
		ESX.UI.Menu.CloseAll()
	end
)
