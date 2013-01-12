--[[--------------------------------------------------------------------
	PhanxBuffs
	Replacement player buff, debuff, and temporary enchant frames.
	Copyright (c) 2010-2013 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://www.curse.com/addons/wow/phanxbuffs
------------------------------------------------------------------------
	German Localization (Deutsch)
	Last updated YYYY-MM-DD by YourName
----------------------------------------------------------------------]]

if GetLocale() ~= "deDE" then return end
local _, ns = ...
ns.L = {

-- Shaman weapon enchant keywords

	["Earthliving"] = "Lebensgeister",
	["Flametongue"] = "Flammenzunge",
	["Frostbrand"] = "Frostbrand",
	["Rockbiter"] = "Felsbeißer",
	["Windfury"] = "Windzorn",

-- Rogue weapon enchant keywords

	["Crippling Poison"] = "Verkrüppel[nu][dn][eg]s%s?[Gg]ift", -- item is Verkrüppelndes Gift, enchant is Verkrüppelungsgift
	["Deadly Poison"] = "Tödliches Gift",
--	["Leeching Poison"] = "",
	["Mind-Numbing Poison"] = "Gedankenbenebelndes Gift",
--	["Paralytic Poison"] = "",
	["Wound Poison"] = "Wundgift",

-- Configuration panel

--	["Use this panel to adjust some basic settings for buff, debuff, and weapon buff icons."] = "",

--	["Buff Size"] = "",
--	["Adjust the size of each buff icon."] = "",
--	["Buff Spacing"] = "",
--	["Adjust the space between buff icons."] = "",
--	["Buff Columns"] = "",
--	["Adjust the number of buff icons to show on each row."] = "",
--	["Buff Anchor"] = "",
--	["Choose whether the buff icons grow from left to right, or right to left."] = "",
--	["Choose whether the buff icons grow from top to bottom, or bottom to top."] = "",

--	["Debuff Size"] = "",
--	["Adjust the size of each debuff icon."] = "",
--	["Debuff Spacing"] = "",
--	["Adjust the space between debuff icons."] = "",
--	["Debuff Columns"] = "",
--	["Adjust the number of debuff icons to show on each row."] = "",
--	["Debuff Anchor"] = "",
--	["Choose whether the debuff icons grow from left to right, or right to left."] = "",
--	["Choose whether the debuff icons grow from top to bottom, or bottom to top."] = "",

--	["Top"] = "",
--	["Bottom"] = "",
--	["Left"] = "",
--	["Right"] = "",

--	["Typeface"] = "",
--	["Set the typeface for the stack count and timer text."] = "",
--	["Text Outline"] = "",
--	["Set the outline weight for the stack count and timer text."] = "",
--	["None"] = "",
--	["Thin"] = "",
--	["Thick"] = "",
--	["Text Size"] = "",
--	["Adjust the size of the stack count and timer text."] = "",

--	["Max Timer Duration"] = "",
--	["Adjust the maximum remaining duration, in seconds, to show the timer text for a buff or debuff."] = "",

--	["Buff Sources"] = "",
--	["Show the name of the party or raid member who cast a buff on you in its tooltip."] = "",
--	["Weapon Buff Sources"] = "",
--	["Show weapon buffs as the spell or item that buffed the weapon, instead of the weapon itself."] = "",
--	["One-Click Cancel"] = "",
--	["Cancel unprotected buffs on the first click, instead of the second. Only works out of combat, and protected buffs like shapeshift forms and weapon buffs will still require two clicks."] = "",
--	["Lock Frames"] = "",
--	["Lock the buff and debuff frames in place, hiding the backdrop and preventing them from being moved."] = "",

--	["Cast by %s"] = "",

--	["Now ignoring buff: %s"] = "",
--	["Now ignoring debuff: %s"] = "",
--	["No longer ignoring buff: %s"] = "",
--	["No longer ignoring debuff: %s"] = "",
--	["No buffs are being ignored."] = "",
--	["No debuffs are being ignored."] = "",
--	["%d |4buff:buffs; |4is:are; being ignored:"] = "",
--	["%d |4debuff:debuffs; |4is:are; being ignored:"] = "",

}