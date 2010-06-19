--[[--------------------------------------------------------------------
	PhanxBuffs
	Replaces default player buff, debuff, and temporary enchant frames.
	by Phanx < addons@phanx.net >
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://wow.curse.com/downloads/wow-addons/details/phanxbuffs.aspx
	Copyright © 2010 Phanx. See README for license terms.
------------------------------------------------------------------------
	Spanish Localization (Español (EU) y Español (AL))
	Last updated YYYY-MM-DD by YourName
----------------------------------------------------------------------]]

if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L, _, ns = { }, ...
ns.L = L

-- Shaman weapon enchant keywords

L["Earthliving"] = "Vida terrestre"
L["Flametongue"] = "Lengua de Fuego"
L["Frostbrand"] = "Estigma de Escarcha"
L["Windfury"] = "Viento Furioso"

-- Rogue weapon enchant keywords

L["Anesthetic Poison"] = "Veneno anestésico"
L["Crippling Poison"] = "Veneno entorpecedor"
L["Deadly Poison"] = "Veneno mortal"
L["Instant Poison"] = "Veneno instantáneo"
L["Mind-Numbing Poison"] = "Veneno de aturdimiento mental"
L["Wound Poison"] = "Veneno hiriente"

-- Warlock weapon enchant keywords

L["Firestone"] = "Piedra de fuego"
L["Spellstone"] = "Piedra de hechizo"

-- Configuration panel text

-- L["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."] = ""
-- L["Buff Size"] = ""
-- L["Adjust the icon size for buffs."] = ""
-- L["Buff Spacing"] = ""
-- L["Adjust the space between icons for buffs."] = ""
-- L["Growth Anchor"] = ""
-- L["Change the side of the screen from which buffs and debuffs grow."] = ""
-- L["Left"] = ""
-- L["Right"] = ""
-- L["Buff Sources"] = ""
-- L["Show the name of the party or raid member who cast a buff on you in its tooltip."] = ""
-- L["Weapon Buff Sources"] = ""
-- L["Show weapon buffs as the spell or item that buffed the weapon, instead of the weapon itself."] = ""
-- L["Lock Frames"] = ""
-- L["Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."] = ""
L["Typeface"] = "Tipo de letra"
L["Change the typeface for stack count and timer text."] = "Cambiar el tipa de letra a utilizar para el texto."
L["Text Outline"] = "Frontera de letra"
L["Change the outline weight for stack count and timer text."] = "Cambiar el grosor de borde para el texto."
L["None"] = "Ninguno"
L["Thin"] = "Fino"
L["Thick"] = "Grueso"
