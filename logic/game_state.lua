local C = require("utils.message_ids")
local EVENT_REGISTRY = require("utils.event_regisrty")

local PLAYER = require("logic.player")
local PLANET_PARAMETERS = require("logic.planet_parameters")
local MA = require("logic.milestones_awards")
local HEX_GRID_STATE = require("logic.hex_grid_state")
local DECK = require("logic.deck")
local GAME_PHASE = require("logic.enums.game_phase")
local TRIGGER = require("logic.trigger")

local M = {}

local function increase_income(recource_name)
	EVENT_REGISTRY.notify(C.PLAYER_RESOURCES_CHANGED, { income_change = {[recource_name] = 1}})
end

local function increase_planet_param(planet_param)
	EVENT_REGISTRY.notify(C.INCREASE_PLANET_PARAMETER, {[planet_param] = { times = 1 }})
end

local function is_all_players_ends_round(self)
	for player_index, player_state in ipairs(self.players) do
		if player_state:is_ends_turn() == false then
			return false
		end
	end
	return true
end

function M.new()
	local planet_parameters = PLANET_PARAMETERS.new()
	planet_parameters:set_triggers(
		TRIGGER.new(C.PLANET_TEMPERATURE, -24, function () increase_income(C.RECOURCE_HEAT) end),
		TRIGGER.new(C.PLANET_TEMPERATURE, -20, function () increase_income(C.RECOURCE_HEAT) end),
		TRIGGER.new(C.PLANET_TEMPERATURE, 0, function () increase_planet_param(C.PLANET_OCEANS) end), --TODO give player a choice where to place ocean
		TRIGGER.new(C.PLANET_OXYGEN, 8, function () increase_planet_param(C.PLANET_TEMPERATURE) end)
	)
	
	local default_game_state = setmetatable({
		game_phase = GAME_PHASE.GAME_SET_UP_PHASE,
		round = 1,
		current_player_index = 1,
		players = { PLAYER.new() },
		planet_parameters = planet_parameters,
		milestones_awards = MA.new(),
		deck = DECK.new(),
		map = HEX_GRID_STATE.new(),
	}, { __index = M })
	
	return default_game_state
end

function M:get_player()
	return self.players[self.current_player_index]
end

function M:get_planet()
	return self.planet_parameters
end

function M:spend_action(played_action)
	local player = self.players[self.current_player_index]
	player:spend_action(played_action)
end

function M:play_card(card, resource_distribution)
	self:get_player():play_card(card, resource_distribution)
end

function M:draw_card(amount)
	amount = amount or 1
	for i = 1, amount do
		self:get_player():add_card(self.deck:draw())
	end
end

function M:skip_turn()
	local player = self.players[self.current_player_index]
	player:skip_turn()
	self.current_player_index = self.current_player_index + 1

	--choose next player
	player = self.players[self.current_player_index]
	if player == nil then
		self.current_player_index = 1
		if is_all_players_ends_round(self) then
			--production phase
			for player_index, player_state in ipairs(self.players) do
				player_state:on_production_phase()
			end
			-- next round
			self.round = self.round + 1
			for player_index, player_state in ipairs(self.players) do
				player_state:on_next_round()
			end
			print("round " .. self.round)
		else
			for player_index, player_state in ipairs(self.players) do
				player_state:on_next_turn()
			end
		end
	end
end

function M:take_milestone_or_award(name)
	self.milestones_awards:take_milestone_or_award(name, self:get_player():get_id())
end

function M:get_milestones_awards()
	return self.milestones_awards
end

function M:get_available_actions()
	return self:get_player():get_available_actions()
end

function M:render_map()
	self.map:render_map_recources()
	self.map:render_map_oceans()
end

function M:tile_placed(tile_type, row, column)
	self.map:set_with_validation(row, column, self.current_player_index, tile_type)
	if tile_type == C.TILE_TYPE_OCEAN then
		increase_planet_param(C.PLANET_OCEANS)
	elseif tile_type == C.TILE_TYPE_TREE then
		increase_planet_param(C.PLANET_OXYGEN)
	end
end


function M:update_ui()
	EVENT_REGISTRY.notify(C.UI_UPDATE_PLANET_PARAMETERS, self:get_planet():get())
	EVENT_REGISTRY.notify(C.UI_UPDATE_MILESTONES_AWARDS, self:get_milestones_awards())
	EVENT_REGISTRY.notify(C.UI_STATE_SET_ACTIONS, { actions =  self:get_player():get_actions() })
	EVENT_REGISTRY.notify(C.UI_UPDATE_RESOURCES, self:get_player():get_resources())
	
	EVENT_REGISTRY.notify(C.PLAYER_TERRAFORM_RATING, { 
		player_id = self:get_player():get_id(),
		terraform_rating = self:get_player():get_terraform_rating()
	})

end


return M