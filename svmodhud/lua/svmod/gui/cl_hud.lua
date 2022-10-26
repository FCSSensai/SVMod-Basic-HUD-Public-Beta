--Credits to Haze for the OG assets used.
AddCSLuaFile()
surface.CreateFont("JaySVHUD:23", {size = 23, weight = 350, antialias = true, extended = true, font = "Roboto Condensed"})

-- Materials
local speed = Material("materials/jayssvhud/speed.png", "smooth mips")
local gazol = Material("materials/jayssvhud/fuel.png", "smooth mips")
local health = Material("materials/jayssvhud/health.png", "smooth mips")

-- Position Text & Icons
local HazeW, HazeH = ScrW(), ScrH()

local xIcons = HazeW * 0.965
local wIcons = HazeH * .04

local yHealth = HazeH * 0.545
local ySpeed = HazeH * 0.445
local yGazol = HazeH * 0.495

local xSpeedText = HazeW * 0.960
local ySpeedText = HazeH * 0.450

local xGazolText = HazeW * 0.962		
local yGazolText = HazeH * 0.500	

local xHealthText = HazeW * 0.960
local yHealthText = HazeH * 0.550

-- Color
local color_white = color_white
local color_black = color_black

-- HUD
local function SV_HUDPaint()
	local Vehicle = LocalPlayer():GetVehicle()
	if not SVMOD:IsVehicle(Vehicle) then return end
	if not Vehicle:SV_IsDriverSeat() then return end
	-- health
	if Vehicle:SV_GetHealth() > 20 then
		draw.SimpleText(math.Round(Vehicle:SV_GetHealth()) .. "% Health", "JaySVHUD:23", xHealthText, yHealthText, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
		surface.SetDrawColor(255, 255, 255)
	else
		draw.SimpleText(math.Round(Vehicle:SV_GetHealth()) .. "% Health", "JaySVHUD:23", xHealthText, yHealthText, RealTime()%0.3 < 0.15 and Color(255, 0, 0) or color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
		surface.SetDrawColor(RealTime()%0.3 < 0.15 and Color(255, 0, 0) or color_white)
	end
	surface.SetMaterial(health)
	surface.DrawTexturedRect(xIcons, yHealth, wIcons, wIcons)
	-- Speed
	if Vehicle:SV_GetCachedSpeed() < 115 then
		draw.SimpleText(math.Round(Vehicle:SV_GetCachedSpeed()*0.621371) .. " Mp/h", "JaySVHUD:23", xSpeedText, ySpeedText, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
		surface.SetDrawColor(255, 255, 255)
	else
		draw.SimpleText(math.Round(Vehicle:SV_GetCachedSpeed()*0.621371) .. " Mp/h", "JaySVHUD:23", xSpeedText, ySpeedText, RealTime()%0.3 < 0.15 and Color(255, 0, 0) or color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
		surface.SetDrawColor(RealTime()%0.3 < 0.15 and Color(255, 0, 0) or color_white)
	end
		
	surface.SetMaterial(speed)
	surface.DrawTexturedRect(xIcons, ySpeed, wIcons, wIcons)

	--

	-- Gazol
	if math.Round(Vehicle:SV_GetFuel()/3.78541, 1) > 5 then
		draw.SimpleText(math.Round(Vehicle:SV_GetFuel()/3.78541, 1) .. " Gallons", "JaySVHUD:23", xGazolText, yGazolText, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
		surface.SetDrawColor(255, 255, 255)
	else
		draw.SimpleText(math.Round(Vehicle:SV_GetFuel()/3.78541, 1) .. " Gallons", "JaySVHUD:23", xGazolText, yGazolText, RealTime()%0.3 < 0.15 and Color(255, 0, 0) or color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
		surface.SetDrawColor(RealTime()%0.3 < 0.15 and Color(255, 0, 0) or color_white)
	end

	surface.SetMaterial(gazol)
	surface.DrawTexturedRect(xIcons, yGazol, wIcons, wIcons)
end

-- Hooks
hook.Add("SV_PlayerEnteredVehicle", "SV_EnableHUD", function(ply, veh)
	hook.Add("HUDPaint", "SV_HUDPaint", SV_HUDPaint)
end)

hook.Add("SV_PlayerLeaveVehicle", "SV_DisableHUD", function()
	hook.Remove("HUDPaint", "SV_HUDPaint")
end)
