local PLAYER = require("logic.player")
local PLANET_PARAMETERS = require("logic.planet_parameters")
local MA = require("logic.milestones_awards")
local GAME_PHASE = require("logic.enums.game_phase")

local M = {}

function M.new()
	return setmetatable({
		game_phase = GAME_PHASE.GAME_SET_UP_PHASE,
		round = 1,
		current_player_index = 1,
		players = { PLAYER.new() },
		planet_parameters = PLANET_PARAMETERS.new(),
		milestones_awards = MA.new(),
	}, { __index = M })
end

function M:get_player()
	return self.players[self.current_player_index]
end

function M:spend_action()
	local player = self.players[self.current_player_index]
	player:spend_action()
end

function M:skip_turn()
	local player = self.players[self.current_player_index]
	print("skip turn", player, self.current_player_index)
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

return M