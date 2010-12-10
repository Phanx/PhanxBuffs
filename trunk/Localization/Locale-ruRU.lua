--[[--------------------------------------------------------------------
PhanxBuffs
Replacement player buff, debuff, and temporary enchant frames.

http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
http://wow.curse.com/downloads/wow-addons/details/phanxbuffs.aspx

Copyright © 2010 Phanx < addons@phanx.net >

I, the copyright holder of this work, hereby release it into the public
domain. This applies worldwide. In case this is not legally possible:
I grant anyone the right to use this work for any purpose, without any
conditions, unless such conditions are required by law.
------------------------------------------------------------------------
	Russian Localization (Русский)
	Last updated YYYY-MM-DD by YourName
----------------------------------------------------------------------]]

if GetLocale() ~= "ruRU" then return end
local L, _, ns = { }, ...
ns.L = L

-- Shaman weapon enchant keywords

L["Earthliving"] = "Жизнь Земли"
L["Flametongue"] = "Язык пламени"
L["Frostbrand"] = "Ледяное клеймо"
L["Rockbiter"] = "Камнедробителя" -- needs check
L["Windfury"] = "Неистовство ветра"

-- Rogue weapon enchant keywords

L["Anesthetic Poison"] = "Анестезирующий яд"
L["Crippling Poison"] = "Калечащий яд"
L["Deadly Poison"] = "Смертельный яд"
L["Instant Poison"] = "Быстродействующий яд"
L["Mind-Numbing Poison"] = "Дурманящий яд"
L["Wound Poison"] = "Нейтрализующий яд"

-- Warlock weapon enchant keywords

L["Firestone"] = "камень огня"
L["Spellstone"] = "камень чар"

-- Configuration panel

-- L["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."] = ""
-- L["Buff Size"] = ""
-- L["Set the size of each buff icon."] = ""
-- L["Buff Spacing"] = ""
-- L["Set the space between buff icons."] = ""
-- L["Buff Columns"] = ""
-- L["Set the number of buff icons to show on each row."] = ""
-- L["Debuff Size"] = ""
-- L["Set the size of each debuff icon."] = ""
-- L["Debuff Spacing"] = ""
-- L["Set the space between debuff icons."] = ""
-- L["Debuff Columns"] = ""
-- L["Set the number of debuff icons to show on each row."] = ""
-- L["Typeface"] = ""
-- L["Set the typeface for stack count and timer text."] = ""
-- L["Text Outline"] = ""
-- L["Set the outline weight for stack count and timer text."] = ""
-- L["None"] = ""
-- L["Thin"] = ""
-- L["Thick"] = ""
-- L["Growth Anchor"] = ""
-- L["Set the side of the screen from which buffs and debuffs grow."] = ""
-- L["Left"] = ""
-- L["Right"] = ""
-- L["Buff Sources"] = ""
-- L["Show the name of the party or raid member who cast a buff on you in its tooltip."] = ""
-- L["Weapon Buff Sources"] = ""
-- L["Show weapon buffs as the spell or item that buffed the weapon, instead of the weapon itself."] = ""
-- L["Lock Frames"] = ""
-- L["Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."] = ""

-- L["Cast by %s"] = ""

-- L["Now ignoring buff: %s."] = ""
-- L["No longer ignoring buff: %s."] = ""
-- L["Now ignoring debuff: %s."] = ""
-- L["No longer ignoring debuff: %s."] = ""
-- L["No buffs are being ignored:"] = ""
-- L["%d buffs are being ignored:"] = ""
-- L["No debuffs are being ignored:"] = ""
-- L["%d debuffs are being ignored:"] = ""