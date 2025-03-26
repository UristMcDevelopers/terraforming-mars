local C = require "utils.message_ids"
local actions = require "logic.action_state"
local RESOURCES = require "logic.resources"


local M = {}

function M.new()
	return setmetatable({
		id = 1,
		terraform_rating = 20,
		corporation = {},
		actions = actions.new(),
		resources = {
			current = RESOURCES.new(),
			income = RESOURCES.new(),
		},

		temporary_hand = {}, --for effects like "choose one of", "buy at the start of round". can be moved to field "hand" 
		hand = {}, 
		tags = {}, --played cards tags can be moved to played_cards as extra field
		played_cards = {}, -- just for score system
		available_actions = {}, -- blue cards effects/actions/standart projects/corporation action/
	}, { __index = M })
end

local function apply_income(self)
	self.resources.current:update(self.resources.income)
	self.resources.current:update_resource(C.RECOURCE_GOLD, self.terraform_rating)
end

local function reset_available_actions_markers(self)
	--TODO implement
end

function M:get_id()
	return self.id
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

function M:on_next_turn()
	self.actions:on_next_turn()
end

function M:available_actions()
	return self.available_actions
end

function M:get_resources()
	return self.resources
end

function M:update_resources(resource_event)
	self.resources.current:update(resource_event.current_change)
	self.resources.income:update(resource_event.income_change)
end

function M:on_production_phase()
	apply_income(self)
	reset_available_actions_markers(self)
end

function M:is_ends_turn()
	return self.actions.ends_turn
end

return M