--[[--------------------------------------------------------------------
	PhanxBuffs
	Replacement player buff, debuff, and temporary enchant frames.
	Copyright (c) 2010-2014 Phanx. All rights reserved.
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://www.curse.com/addons/wow/phanxbuffs

	Please DO NOT upload this addon to other websites, or post modified
	versions of it. However, you are welcome to include a copy of it
	WITHOUT CHANGES in compilations posted on Curse and/or WoWInterface.
	You are also welcome to use any/all of its code in your own addon, as
	long as you do not use my name or the name of this addon ANYWHERE in
	your addon, including its name, outside of an optional attribution.
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
				for i, tex in pairs(f.BorderTextures) do
					tex:SetTexture(nil)
					tex:Hide()
				end
				f.BorderTextures = nil
			end
			if f.ShadowTextures then
				for i, tex in pairs(f.ShadowTextures) do
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
		for i = 1, #buttonDataLayers do
			f.buttonData[buttonDataLayers[i]] = false
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

		for i = 1, #buttons do
			-- print("Skinning button " .. i .. " in frame " .. frame:GetName() .. "...")
			SkinButton(buttons[i])
		end

		local oldmetatable = getmetatable(buttons).__index
		setmetatable(buttons, { __index = function(t, i)
			local f = oldmetatable(t, i)
			-- print("Creating skinned button in frame " .. f:GetParent():GetName() .. "...")
			SkinButton(f)
			return f
		end })
	end

	local hooked
	local function ReSkin(button, size)
		size = floor(size)
		if size ~= button.prevsize then
			-- print("reskinning on size change", button.prevsize, "=>", size)
			button.prevsize = size
			Masque:Group("PhanxBuffs"):ReSkin()
		end
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

		if not hooked then
			hooksecurefunc(PhanxBuffFrame.buttons[1], "SetHeight", ReSkin)
			hooksecurefunc(PhanxDebuffFrame.buttons[1], "SetHeight", ReSkin)
			hooked = true
		end
	end

	Masque:Register("PhanxBuffs", OnSkinChanged)

	SkinFrame(PhanxBuffFrame)
	SkinFrame(PhanxDebuffFrame)
	SkinFrame(PhanxTempEnchantFrame)

	done = true
end)