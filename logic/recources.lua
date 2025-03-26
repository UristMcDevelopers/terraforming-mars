local C = require("utils.message_ids")

local M = {}

function M.new()
	return setmetatable({
		[C.RECOURCE_GOLD] = 0,
		[C.RECOURCE_STEEL] = 0,
		[C.RECOURCE_TITANIUM] = 0,
		[C.RECOURCE_PLANT] = 0,
		[C.RECOURCE_ELECTRICITY] = 0,
		[C.RECOURCE_HEAT] = 0,
	}, { __index = M })
end

return M