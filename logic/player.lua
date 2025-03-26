local actions = require "logic.action_state"
local recources = require "logic.recources"

local M = {}

function M.new()
	return setmetatable({
		id = 1,
		terraform_rating = 20,
		corporation = {},
		actions = actions.new(),
		recources = {
			current = recources.new(),
			income = recources.new(),
		},

		temporary_hand = {}, --for effects like "choose one of", "buy at the start of round". can be moved to field "hand" 
		hand = {}, 
		tags = {}, --played cards tags can be moved to played_cards as extra field
		played_cards = {}, -- just for score system
		available_actions = {}, -- blue cards effects/actions/standart projects/corporation action/
	}, { __index = M })
end

function M:get_actions()
	return self.actions:get_actions()
end

function M:spend_action()
	self.actions:spend_action()
end

function M:skip_turn()
	self.actions:skip_turn()
end

function M:on_next_round()
	self.actions:on_next_round()
end

return M