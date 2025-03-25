local C = require("utils.message_ids")

local M = {}

function M.new(name)
	assert(name)
	return setmetatable({
		name = name,
		taken_by = nil,
	}, { __index = M })
end

function M:take(player_id)
	self.taken_by = player_id
end

return M