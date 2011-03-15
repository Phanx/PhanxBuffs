--[[--------------------------------------------------------------------
	PhanxBuffs
	Replacement player buff, debuff, and temporary enchant frames.
	Written by Phanx <addons@phanx.net>
	Maintained by Akkorian <akkorian@hotmail.com>
	Copyright © 2010–2011 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://wow.curse.com/downloads/wow-addons/details/phanxbuffs.aspx
----------------------------------------------------------------------]]

local PhanxBuffFrame = CreateFrame("Frame", "PhanxBuffFrame", UIParent)

local db
local ignore

local buffs, cantCancel = { }, { }
local buffUnit = "player"

local _, ns = ...
local GetFontFile = ns.GetFontFile

local L = ns.L
L["Cast by |cff%02x%02x%02x%s|r"] = L["Cast by %s"]:replace("%s", "|cff%02x%02x%02x%s|r")

local MAX_BUFFS = 40

local WOW_VERSION = select(4, GetBuildInfo())

------------------------------------------------------------------------

local unitNames = setmetatable({ }, { __index = function(t, unit)
	if not unit then return end

	local name = UnitName(unit)
	if not name then return end

	local _, class = UnitClass(unit)
	if not class then return L["Cast by %s"]:format(name) end

	local color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
	if not color then return L["Cast by %s"]:format(name) end

	return L["Cast by |cff%02x%02x%02x%s|r"]:format(color.r * 255, color.g * 255, color.b * 255, name)
end })

local function button_OnEnter(self)
	local buff = buffs[self:GetID()]
	if not buff then return end

	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
	GameTooltip:SetUnitAura(buffUnit, buff.index, "HELPFUL")

	if db.showBuffSources then
		local caster = unitNames[buff.caster]
		if caster then
			GameTooltip:AddLine(caster)
			GameTooltip:Show()
		end
	end
end

local function button_OnLeave()
	GameTooltip:Hide()
end

local function button_OnClick(self)
	local buff = buffs[self:GetID()]
	if not buff then return end

	if IsAltKeyDown() and IsShiftKeyDown() then
		ignore[buff.name] = true
		print("|cffffcc00PhanxBuffs:|r", string.format(ns.L["Now ignoring buff: %s"], buff.name))
		self:GetParent():Update()
	elseif WOW_VERSION < 40000 then
		CancelUnitBuff(buffUnit, buff.index, "HELPFUL")
	elseif not buff.noCancel then
		PhanxBuffsCancelButton:SetMacro(self, buff.icon, "/cancelaura " .. buff.name)
	end
end

local buttons = setmetatable({ }, { __index = function(t, i)
	if type(i) ~= "number" then return end

	local button = CreateFrame("Button", nil, PhanxBuffFrame)
	button:SetID(i)
	button:SetWidth(db.buffSize)
	button:SetHeight(db.buffSize)
	button:Show()

	button:EnableMouse(true)
	button:SetScript("OnEnter", button_OnEnter)
	button:SetScript("OnLeave", button_OnLeave)

	button:RegisterForClicks("RightButtonUp")
	button:SetScript("OnClick", button_OnClick)

	button.icon = button:CreateTexture(nil, "BACKGROUND")
	button.icon:SetAllPoints(true)

	button.count = button:CreateFontString(nil, "OVERLAY")
    button.count:SetPoint("CENTER", button, "TOP")
    button.count:SetShadowOffset(1, -1)

	button.timer = button:CreateFontString(nil, "OVERLAY")
	button.timer:SetPoint("TOP", button, "BOTTOM")
    button.timer:SetShadowOffset(1, -1)

	if PhanxBorder then
		PhanxBorder.AddBorder(button)
		button.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
	end

	t[i] = button

	PhanxBuffFrame:UpdateLayout()

	return button
end })

PhanxBuffFrame.buttons = buttons

------------------------------------------------------------------------

function PhanxBuffFrame:UpdateLayout()
	local anchor = db.growthAnchor
	local size = db.buffSize
	local spacing = db.iconSpacing
	local cols = db.buffColumns
	local rows = math.ceil(MAX_BUFFS / cols)

	local fontFace = GetFontFile(db.fontFace)
	local fontScale = db.fontScale
	local fontOutline = db.fontOutline

	local numEnchants = PhanxTempEnchantFrame.numEnchants or 0
	for i, button in ipairs(buttons) do
		local j = i + numEnchants

		local col = (j - 1) % cols
		local row = math.ceil(j / cols) - 1

		local x = col * (spacing + size) * (anchor == "LEFT" and 1 or -1)
		local y = row * (spacing + (size * 1.5))

		button:ClearAllPoints()
		button:SetWidth(size)
		button:SetHeight(size)
		button:SetPoint("TOP" .. anchor, self, "TOP" .. anchor, x, -y)

		button.count:SetFont(fontFace, 18 * fontScale, fontOutline)
		button.timer:SetFont(fontFace, 14 * fontScale, fontOutline)
	end

	self:ClearAllPoints()
	if db.buffPoint and db.buffX and db.buffY then
		self:SetPoint(db.buffPoint, UIParent, db.buffX, db.buffY)
	else
		self:SetPoint("TOPRIGHT", UIParent, -70 - Minimap:GetWidth(), -30)
	end
	self:SetWidth((size * cols) + (spacing * (cols - 1)))
	self:SetHeight((size * rows) + (spacing * (rows - 1)))
end

------------------------------------------------------------------------

local function BuffSort(a, b)
	if a.duration == 0 then
		if b.duration == 0 then
			-- both timeless, sort by name REVERSE
			return a.name < b.name
		else
			-- a timeless, b not
			return true
		end
	else
		if b.duration == 0 then
			-- b timeless, a not
			return false
		else
			-- neither timeless, sort by expiry time
			return a.expires > b.expires
		end
	end
end

------------------------------------------------------------------------

local tablePool = { }

local function newTable()
	local t = next(tablePool) or {}
	tablePool[t] = nil
	return t
end

local function remTable(t)
	if type(t) == "table" then
		for k, v in pairs(t) do
			t[k] = nil
		end
		t[true] = true
		t[true] = nil
		tablePool[t] = true
	end
	return nil
end

------------------------------------------------------------------------

function PhanxBuffFrame:Update()
	for i, t in ipairs(buffs) do
		buffs[i] = remTable(t)
	end

	for i = 1, 100 do
		local name, _, icon, count, kind, duration, expires, caster, _, _, spellID = UnitAura(buffUnit, i, "HELPFUL")
		if not name or not icon or icon == "" then break end

		if not ignore[name] then
			local t = newTable()

			t.name = name
			t.icon = icon
			t.count = count
			t.kind = kind
			t.duration = duration or 0
			t.expires = expires
			t.caster = caster
			t.spellID = spellID
			t.index = i

			buffs[#buffs + 1] = t
		end
	end

	table.sort(buffs, BuffSort)

	wipe(cantCancel)
	for i = 1, 100 do
		local name, _, icon = UnitAura(buffUnit, i, "HELPFUL NOT_CANCELABLE")
		if not name or not icon or icon == "" then break end
		cantCancel[name] = true
	end

	for i, buff in ipairs(buffs) do
		local f = buttons[i]
		f.icon:SetTexture(buff.icon)

		buff.noCancel = cantCancel[buff.name]

		if buff.count > 1 then
			f.count:SetText(buff.count)
		else
			f.count:SetText()
		end

		f:Show()
	end

	if #buttons > #buffs then
		for i = #buffs + 1, #buttons do
			local f = buttons[i]
			f.icon:SetTexture()
			f.count:SetText()
			f:Hide()
		end
	end
end

------------------------------------------------------------------------

local dirty
local timerGroup = PhanxBuffFrame:CreateAnimationGroup()
local timer = timerGroup:CreateAnimation()
timer:SetOrder(1)
timer:SetDuration(0.1) -- how often you want it to finish
-- timer:SetMaxFramerate(20) -- use this to throttle
timerGroup:SetScript("OnFinished", function(self, requested)
	if dirty then
		PhanxBuffFrame:Update()
		dirty = false
	end
	local max = db.maxTimer
	for i, button in ipairs(buttons) do
		if not button:IsShown() then break end
		local buff = buffs[ button:GetID() ]
		if buff then
			if buff.expires > 0 then
				local remaining = buff.expires - GetTime()
				if remaining < 0 then
					-- bugged out, kill it
					remTable( table.remove( buffs, button:GetID() ) )
					dirty = true
				elseif remaining <= max then
					if remaining > 3600 then
						button.timer:SetFormattedText( HOUR_ONELETTER_ABBR, floor( ( remaining / 60 ) + 0.5 ) )
					elseif remaining > 60 then
						button.timer:SetFormattedText( MINUTE_ONELETTER_ABBR, floor( ( remaining / 60 ) + 0.5 ) )
					else
						button.timer:SetText( floor( remaining + 0.5 ) )
					end
				else
					button.timer:SetText()
				end
			else
				button.timer:SetText()
			end
		end
	end
	self:Play() -- start it over again
end)

------------------------------------------------------------------------

PhanxBuffFrame:SetScript("OnEvent", function( self, event, unit )
	if event == "UNIT_AURA" then
		if unit == buffUnit then
			dirty = true
		end
	elseif event == "PLAYER_ENTERING_WORLD" then
		if ( UnitInVehicle( "player" ) and SecureCmdOptionParse( "[bonusbar:5]" ) ) then
			buffUnit = "vehicle"
		else
			buffUnit = "player"
		end
		dirty = true
	elseif event == "UNIT_ENTERED_VEHICLE" then
		if unit == "player" and SecureCmdOptionParse( "[bonusbar:5]" ) then
			buffUnit = "vehicle"
			dirty = true
		end
	elseif event == "UNIT_EXITED_VEHICLE" then
		if unit == "player" then
			buffUnit = "player"
			dirty = true
		end
	end
end)

------------------------------------------------------------------------

function PhanxBuffFrame:Load()
	if db then return end

	db = PhanxBuffsDB
	ignore = PhanxBuffsIgnoreDB.buffs

	dirty = true
	timerGroup:Play()

	self:RegisterEvent( "PLAYER_ENTERING_WORLD" )
	self:RegisterEvent( "UNIT_ENTERING_VEHICLE" )
	self:RegisterEvent( "UNIT_EXITING_VEHICLE" )
	self:RegisterEvent( "UNIT_AURA" )
end