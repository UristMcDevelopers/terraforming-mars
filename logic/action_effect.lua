local ASSERTS = require("utils.assertions")
local ENUM_ACTION_EFFECT = require("logic.enums.action_effect_type")
local ENUM_RECOURCE = require("logic.enums.resource_type")

local M = {}

--TODO maybe add different functions for spend_effect and get_effect. with different assertions
function M.new(text, type, resource_type, amount, target)
	ASSERTS.value_of_enum(ENUM_ACTION_EFFECT, type)
	ASSERTS.type_number(amount)

	return setmetatable({
		text = text,
		type = type,
		resource_type = resource_type,
		planet_param_type = nil,
		amount = amount,
		target = target,
	}, { __index = M })
end

function M.increase_income(resource_type, amount)
	return M.new(nil, ENUM_ACTION_EFFECT.INCOME, resource_type, amount, nil)
end

function M.get_resources(resource_type, amount)
	return M.new(nil, ENUM_ACTION_EFFECT.RESOURCE, resource_type, amount, nil)
end

return M
