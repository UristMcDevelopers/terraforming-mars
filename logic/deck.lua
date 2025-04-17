local CARD = require("logic.cards.card")

local M = {}

local function default_deck()
	return {
		CARD.new("Ants", "ant desc", 10), 
		CARD.new("Ants2", "ant desc3", 11), 
		CARD.new("Ants3", "ant desc3", 12), 
		CARD.new("Ants4", "ant desc4", 12), 
		CARD.new("Ants", "ant desc", 10), 
		CARD.new("Ants2", "ant desc3", 11), 
		CARD.new("Ants3", "ant desc3", 12), 
		CARD.new("Ants4", "ant desc4", 12) 
	}
end

function M.new(deck_cards, discard_cards)
	deck_cards = deck_cards or default_deck()
	discard_cards = discard_cards or {}
	return setmetatable({
		cards = deck_cards,
		discard = discard_cards,
	}, { __index = M })
end

function M:add_to_deck(card)
	table.insert(self.cards, card)
end


function M:draw()
	local size = #self.cards
	return table.remove(self.cards, rnd.range(1, size))
end

function M:add_to_discard(card)
	table.insert(self.discard, card)
end

function M:shuffle()
	for _, card in ipairs(self.discard) do
		self:add_to_deck(card)
	end
	self.discard = {}
end


return M