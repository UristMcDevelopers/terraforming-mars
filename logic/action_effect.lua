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
		amount = amount,
		target = target
	}, { __index = M })
end



return M