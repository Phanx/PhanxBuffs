--[[--------------------------------------------------------------------
	PhanxBuffs
	Replacement player buff, debuff, and temporary enchant frames.
	Copyright (c) 2010-2013 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://www.curse.com/addons/wow/phanxbuffs
----------------------------------------------------------------------]]

local Masque = LibStub("Masque", true)
if not Masque then return end

local done
local _, ns = ...

hooksecurefunc(PhanxTempEnchantFrame, "Load", function(self)
	-- print("Initializing skin support...")
	if done then return end

	local db = PhanxBuffsDB
	if db.noMasque then return end
	if db.skin then
		-- print("Removing old skin data...")
		db.skin = nil
	end

	local buttonDataLayers = { "AutoCast", "AutoCastable", "Backdrop", "Checked", "Cooldown", "Count", "Disabled", "Flash", "Highlight", "HotKey", "Name", "Pushed" }

	local function SkinButton(f)
		-- print("Skinning button in frame " .. f:GetParent():GetName() .. "...")

		if PhanxBorder then
			f.icon:SetTexCoord(0, 1, 0, 1)
			if f.BorderTextures then
				for i, tex in ipairs(f.BorderTextures) do
					tex:SetTexture(nil)
					tex:Hide()
				end
				f.BorderTextures = nil
			end
			if f.ShadowTextures then
				for i, tex in ipairs(f.ShadowTextures) do
					tex:SetTexture(nil)
					tex:Hide()
				end
				f.ShadowTextures = nil
			end
			f.SetBorderSize = nil
		elseif f.border then
			f.border:SetTexture(nil)
			f.border:Hide()
			f.border = nil
		end

		f.buttonData = { Icon = f.icon }
		for i, layer in ipairs(buttonDataLayers) do
			f.buttonData[layer] = false
		end

		if f:GetParent() == PhanxBuffFrame then
			f.buttonData.Border = false
		else
			f.border = f.border or f:CreateTexture()
			f.buttonData.Border = f.border
		end

		if f.SetBorderColor then
			f.SetBorderColor = function(f, r, g, b, a)
				if a and a > 0 then
					f.border:SetVertexColor(r, g, b, a)
				else
					f.border:SetVertexColor(1, 1, 1, 0)
				end
			end
		end

		Masque:Group("PhanxBuffs"):AddButton(f, f.buttonData)

		if f:GetParent() == PhanxTempEnchantFrame then
			-- print("Recoloring temp enchant button")
			f.border:SetVertexColor(0.46, 0.18, 0.67, 1)
		end
	end

	local function SkinFrame(frame)
		-- print("Skinning frame " .. frame:GetName() .. "...")
		local buttons = frame.buttons

		for i, button in ipairs(buttons) do
			-- print("Skinning button " .. i .. " in frame " .. frame:GetName() .. "...")
			SkinButton(button)
		end

		local oldmetatable = getmetatable(buttons).__index
		setmetatable(buttons, { __index = function(t, i)
			local f = oldmetatable(t, i)
			-- print("Creating skinned button in frame " .. f:GetParent():GetName() .. "...")
			SkinButton(f)
			return f
		end })
	end

	local function OnSkinChanged(_, _, skin, gloss, backdrop, colors, fonts)
		-- print(string.format("New skin: %s, Gloss: %s, Backdrop: %s", skin, tostring(gloss), tostring(backdrop)))

		for i = 1, #PhanxTempEnchantFrame.buttons do
			-- print("Recoloring temp enchant button", i)
			PhanxTempEnchantFrame.buttons[i].border:SetVertexColor(0.46, 0.18, 0.67, 1)
		end

		PhanxBuffFrame:Update()
		PhanxDebuffFrame:Update()
		PhanxTempEnchantFrame:Update()
	end

	Masque:Register("PhanxBuffs", OnSkinChanged)

	SkinFrame(PhanxBuffFrame)
	SkinFrame(PhanxDebuffFrame)
	SkinFrame(PhanxTempEnchantFrame)

	local hookedOptionsPanel
	ns.optionsPanel:HookScript("OnShow", function(panel)
		if hookedOptionsPanel then return end

		local L = ns.L
		for i = 1, panel:GetNumChildren() do
			local child = select(i, panel:GetChildren())
			if type(child) == "table" and child.OnValueChanged and child.labelText then
				local name = child.labelText:GetText()
				if name == L["Buff Size"] or name == L["Debuff Size"] then
					local OnValueChanged = child.OnValueChanged
					child.OnValueChanged = function(...)
						OnValueChanged(...)
						Masque:Group("PhanxBuffs"):ReSkin()
					end
				end
			end
		end

		hookedOptionsPanel = true
	end)

	done = true
end)