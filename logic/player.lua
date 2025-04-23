local C = require "utils.message_ids"
local actions = require "logic.action_state"
local RESOURCES = require "logic.resources"
local standart_projects = require("logic.actions.standarts.standart_projects")
local _card = require("logic.cards.card")
local EFFECT_TYPE = require("logic.enums.action_effect_type")
local TARGET_TYPE = require("logic.enums.target_type")
local EVENT_REGISTRY = require("utils.event_regisrty")



local M = {}

function M.new()
	return setmetatable({
		id = 1,
		color = C.PLAYER_1_COLOR,
		terraform_rating = 20,
		corporation = {},
		actions = actions.new(),
		resources = {
			current = RESOURCES.new(),
			income = RESOURCES.new(),
		},
		steel_worth = 2,
		titanium_worth = 3,

		temporary_hand = {}, --for effects like "choose one of", "buy at the start of round". can be moved to field "hand" 
		hand = { 
		-- 	_card.new("Ants", "ant desc", 10), _card.new("Ants2", "ant desc3", 11), _card.new("Ants3", "ant desc3", 12), 
		-- _card.new("Ants4", "ant desc4", 12), _card.new("Ants", "ant desc", 10), _card.new("Ants2", "ant desc3", 11), _card.new("Ants3", "ant desc3", 12), 
		-- _card.new("Ants4", "ant desc4", 12) 
	}, 
		tags = {}, --played cards tags can be moved to played_cards as extra field
		played_cards = {}, -- just for score system
		available_actions = {
			standart_projects.new_increase_electicity_income(),
			standart_projects.new_asteroid(),
			standart_projects.new_ocean(),
			standart_projects.new_tree(),
			standart_projects.new_city(),
			standart_projects.new_spend_heat(),
			standart_projects.new_spend_plants(),
		}, -- blue cards effects/actions/standart projects/corporation action/
	}, { __index = M })
end

local function apply_income(self)
	self.resources.current:electricity_transfer_to_heat()
	self.resources.current:update(self.resources.income)
	self.resources.current:update_resource(C.RECOURCE_GOLD, self.terraform_rating)
end

local function reset_available_actions_markers(self)
	--TODO implement
end

function M:get_id()
	return self.id
end

function M:get_terraform_rating()
	return self.terraform_rating
end

function M:increase_terraform_rating(amount)
	amount = amount or 1
	self.terraform_rating = self.terraform_rating + amount
end

function M:get_actions()
	return self.actions:get_actions()
end

function M:get_available_actions()
	local _available_actions = {}
	for _, action in ipairs(self.available_actions) do
		if action:is_available() then
			table.insert(_available_actions, action)
		end
	end
	return _available_actions
end

function M:get_cards()
	return self.hand
end

function M:add_card(card)
	assert(card)
	table.insert(self.hand, card)
end

function M:play_card(card, resource_distribution)
	--remove card from hand
	local card_index = -1
	for index, card_in_hand in ipairs(self.hand) do
		if card_in_hand.id == card.id then
			card_index = index
			break
		end
	end
	table.remove(self.hand, card_index)
	--remove resources
	for resource_name, update_value in pairs(resource_distribution) do
		self.resources.current:update_resource(resource_name, update_value)
	end

	--TODO apply card effects
	
end

function M:spend_action(played_action)
	for index, value in ipairs(self.available_actions) do
		if value.id == played_action.id then
			pprint("find played action", value)
			value:effect_played()
		end
	end
	self.actions:spend_action()


	--TODO think where to put this code for applying action effects 
	local type = played_action.spend.type
	local resource_type = played_action.spend.resource_type
	local amount = played_action.spend.amount
	local target = played_action.spend.target
	print("spend_action", type, resource_type, amount, target)
	if EFFECT_TYPE.RESOURCE == type then
		self.resources.current:update_resource(resource_type, amount)
	elseif EFFECT_TYPE.INCOME == type then
		self.resources.income:update_resource(resource_type, amount)
	elseif EFFECT_TYPE.RESOURCE_ON_CARD == type then
		if target == TARGET_TYPE.THIS then
			--TODO find card, delete token from it
		elseif target == TARGET_TYPE.OTHER then
			--TODO give player to choose other card, even from other player(add other player tag on card)
		elseif target == TARGET_TYPE.ANY then
			--TODO find suitable cards to choose from (it's delete)
		end
	elseif EFFECT_TYPE.SELL_CARDS == type then
		--TODO give player multi choice of cards to sell
	end

	for _, get_effect in ipairs(played_action.get) do
		type = get_effect.type
		resource_type = get_effect.resource_type
		amount = get_effect.amount
		target = get_effect.target
		print("get effect", type, resource_type, amount, target)
		
		if EFFECT_TYPE.RESOURCE == type then
			self.resources.current:update_resource(resource_type, amount)
		elseif EFFECT_TYPE.INCOME == type then
			self.resources.income:update_resource(resource_type, amount)
		elseif EFFECT_TYPE.RESOURCE_ON_CARD == type then
			if target == TARGET_TYPE.THIS then
				--TODO find card, delete token from it
			elseif target == TARGET_TYPE.OTHER then
				--TODO give player to choose other card, even from other player(add other player tag on card)
			elseif target == TARGET_TYPE.ANY then
				--TODO find suitable cards to choose from (it's delete)
			end
		elseif EFFECT_TYPE.SELL_CARDS == type then
			--TODO give player multi choice of cards to sell
		elseif EFFECT_TYPE.PLANET_PARAM == type then
			EVENT_REGISTRY.notify(C.INCREASE_PLANET_PARAMETER, {[resource_type] = { times = amount }})
		elseif EFFECT_TYPE.PLACE_THE_TILE == type then
			EVENT_REGISTRY.notify(C.GIVE_PLAYER_TO_PLACE_TILE, { tile_type = resource_type, player_color = self.color })
		end
	end


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

function M:get_resources()
	return self.resources
end

function M:update_resources(resource_event)
	self.resources.current:update(resource_event.current_change or {})
	self.resources.income:update(resource_event.income_change or {})
end

function M:on_production_phase()
	apply_income(self)
	reset_available_actions_markers(self)
end

function M:is_ends_turn()
	return self.actions.ends_turn
end

return M