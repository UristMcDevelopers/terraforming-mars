local C = require("utils.message_ids")
local resource_type = require("logic.enums.resource_type")

local M = {}

function M.new_by_tag(tag_type, amount)
	return setmetatable({
		_type = "tag",
		tag_type = tag_type,
		more_or_equal = 1
	}, { __index = M })
end

function M.new_by_planet_param_more(planet_param, amount)
	return setmetatable({
		_type = "planet_param",
		planet_param_type = planet_param,
		more_or_equal = amount
	}, { __index = M })
end

function M.new_by_planet_param_less(planet_param, amount)
	return setmetatable({
		_type = "planet_param",
		planet_param_type = planet_param,
		less_or_equal = amount
	}, { __index = M })
end

function M.new_by_rescource_income(rescource, amount)
	return setmetatable({
		_type = "rescource_income",
		rescource_type = rescource,
		more_or_equal = amount
	}, { __index = M })
end

return M