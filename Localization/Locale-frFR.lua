--[[--------------------------------------------------------------------
	PhanxBuffs
	Replaces default player buff, debuff, and temporary enchant frames.
	by Phanx < addons@phanx.net >
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://wow.curse.com/downloads/wow-addons/details/phanxbuffs.aspx
	Copyright © 2010 Phanx. See README for license terms.
------------------------------------------------------------------------
	French Localization (Français)
	Last updated YYYY-MM-DD by YourName
----------------------------------------------------------------------]]

if GetLocale() ~= "frFR" then return end
local L, _, ns = { }, ...
ns.L = L

-- Shaman weapon enchant keywords

L["Earthliving"] = "Viveterre"
L["Flametongue"] = "Langue de feu"
L["Frostbrand"] = "Arme de givre"
L["Windfury"] = "Furie-des-vents"

-- Rogue weapon enchant keywords

L["Anesthetic Poison"] = "Poison anesthésiant"
L["Crippling Poison"] = "Poison affaiblissant"
L["Deadly Poison"] = "Poison mortel"
L["Instant Poison"] = "Poison instantané"
L["Mind-Numbing Poison"] = "Poison de Distraction mentale" -- item name has lowercase d
L["Wound Poison"] = "Poison douloureux"

-- Warlock weapon enchant keywords

L["Firestone"] = "Pierre de feu"
L["Spellstone"] = "Pierre de sort"

-- Configuration panel

-- L["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."] = ""
-- L["Buff Size"] = ""
-- L["Adjust the icon size for buffs."] = ""
-- L["Buff Spacing"] = ""
-- L["Adjust the space between icons for buffs."] = ""
-- L["Buff Sources"] = ""
-- L["Show the name of the party or raid member who cast a buff on you in its tooltip."] = ""
-- L["Weapon Buff Sources"] = ""
-- L["Show weapon buffs as the spell or item that buffed the weapon, instead of the weapon itself."] = ""
-- L["Typeface"] = ""
-- L["Change the typeface for stack count and timer text."] = ""
-- L["Text Outline"] = ""
-- L["Change the outline weight for stack count and timer text."] = ""
-- L["None"] = ""
-- L["Thin"] = ""
-- L["Thick"] = ""
