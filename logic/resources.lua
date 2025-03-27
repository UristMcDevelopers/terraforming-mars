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

function M:update_resource(resource_name, update_value)
	self[resource_name] = self[resource_name] + update_value
end

function M:update(map)
	for resource_name, update_value in pairs(map) do
		self[resource_name] = self[resource_name] + update_value 
	end
end

return M