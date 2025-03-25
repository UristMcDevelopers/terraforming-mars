local C = require("utils.message_ids")

local M = {}

function M.new()
	return setmetatable({
		[C.PLANET_TEMPERATURE] = -30,
		[C.PLANET_OXYGEN] = 0,
		[C.PLANET_OCEANS] = 0,
	}, { __index = M })
end

function M:get()
	return {
		[C.PLANET_TEMPERATURE] = self[C.PLANET_TEMPERATURE],
		[C.PLANET_OXYGEN] = self[C.PLANET_OXYGEN],
		[C.PLANET_OCEANS] = self[C.PLANET_OCEANS],
	}
end

return M