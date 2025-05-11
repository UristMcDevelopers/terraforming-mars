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

function M:update_all_resources(map)
	for resource_name, update_value in pairs(map) do
		self:update_resource(resource_name, update_value)
	end
end

function M:electricity_transfer_to_heat()
	local transfer = self[C.RECOURCE_ELECTRICITY]
	self[C.RECOURCE_ELECTRICITY] = 0
	self[C.RECOURCE_HEAT] = self[C.RECOURCE_HEAT] + transfer
end

return M

