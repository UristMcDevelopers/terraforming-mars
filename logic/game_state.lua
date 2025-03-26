local C = require("utils.message_ids")
local EVENT_REGISTRY = require("utils.event_regisrty")

local PLAYER = require("logic.player")
local PLANET_PARAMETERS = require("logic.planet_parameters")
local MA = require("logic.milestones_awards")
local HEX_GRID_STATE = require("logic.hex_grid_state")
local GAME_PHASE = require("logic.enums.game_phase")
local TRIGGER = require("logic.trigger")

local M = {}

local function increase_income(recource_name)
	EVENT_REGISTRY.notify(C.PLAYER_INCOME_CHANGED, {[recource_name] = 1})
end

local function increase_planet_param(planet_param)
	EVENT_REGISTRY.notify(C.INCREASE_PLANET_PARAMETER, {[planet_param] = { times = 1 }})
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

function M:spend_action()
	local player = self.players[self.current_player_index]
	player:spend_action()
end

function M:skip_turn()
	local player = self.players[self.current_player_index]
	player:skip_turn()
	self.current_player_index = self.current_player_index + 1

	--choose next player
	player = self.players[self.current_player_index]
	if player == nil then
		-- next round
		self.current_player_index = 1
		self.round = self.round + 1
		for player_index, player_state in ipairs(self.players) do
			player_state:on_next_round()
		end
		print("round " .. self.round)
	end
end

function M:take_milestone_or_award(name)
	self.milestones_awards:take_milestone_or_award(name, self:get_player():get_id())
end

function M:get_milestones_awards()
	return self.milestones_awards
end

return M