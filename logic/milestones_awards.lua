local C = require("utils.message_ids")
local ma = require("logic.ma")

local M = {}

function M.new()
	return setmetatable({
		milestones = {
			[C.MILESTONE_TERRAFORMER] = ma.new(C.MILESTONE_TERRAFORMER),
			[C.MILESTONE_MAYOR] = ma.new(C.MILESTONE_MAYOR),
			[C.MILESTONE_GARDENER] = ma.new(C.MILESTONE_GARDENER),
			[C.MILESTONE_BUILDER] = ma.new(C.MILESTONE_BUILDER),
			[C.MILESTONE_PLANNER] = ma.new(C.MILESTONE_PLANNER),
		},
		awards = {
			[C.AWARD_LANDLORD] = ma.new(C.AWARD_LANDLORD),
			[C.AWARD_BANKER] = ma.new(C.AWARD_BANKER),
			[C.AWARD_SCIENTIST] = ma.new(C.AWARD_SCIENTIST),
			[C.AWARD_THERMALIST] = ma.new(C.AWARD_THERMALIST),
			[C.AWARD_MINER] = ma.new(C.AWARD_MINER),
		},
	}, { __index = M })
end

function M:get_milestones()
	return self.milestones
end

function M:get_awards()
	return self.awards
end

function M:take_milestone_or_award(name, player_id)
	local milestone_or_award = self.milestones[name] or self.awards[name]
	milestone_or_award:take(player_id)
end

return M

