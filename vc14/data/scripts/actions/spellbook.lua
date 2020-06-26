local spellbook = Action()

function spellbook.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local text = {}
	local spells = {}
	for _, spell in ipairs(player:getInstantSpells()) do
		if spell:level() ~= 0 then
			if spell:manaPercent() > 0 then
				spell.mana = spell:manaPercent() .. "%"
			end
			spells[#spells + 1] = spell
		end
	end

	table.sort(spells, function(a, b) return a.level < b.level end)

	local prevLevel = -1
	for i, spell in ipairs(spells) do
		if prevLevel ~= spell:level() then
			if i == 1 then
				text[#text == nil and 1 or #text+1] = "Magias para Level "
			else
				text[#text+1] = "\nMagias para Level "
			end
			text[#text+1] = spell:level() .. "\n"
			prevLevel = spell:level()
		end
		local words, wordsSeparator = spell:words()
		text[#text+1] = words .. " - " .. spell:name() .. " : " .. spell:mana() .. "\n"
	end

	player:showTextDialog(item:getId(), table.concat(text))
	return true
end

spellbook:id(2175, 6120, 8900, 8901, 8902, 8903, 8904, 8918)
spellbook:register()