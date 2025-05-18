local C = require("utils.message_ids")
local EVENT_REGISTRY = require("utils.event_regisrty")

local M = {}

local MAX_VALUES = {
	[C.PLANET_TEMPERATURE] = 8,
	[C.PLANET_OXYGEN] = 14,
	[C.PLANET_OCEANS] = 9,
}

function M.new()
	return setmetatable({
		[C.PLANET_TEMPERATURE] = -30,
		[C.PLANET_OXYGEN] = 0,
		[C.PLANET_OCEANS] = 0,
		triggers = {},
	}, { __index = M })
end

function M:get()
	return {
		[C.PLANET_TEMPERATURE] = self[C.PLANET_TEMPERATURE],
		[C.PLANET_OXYGEN] = self[C.PLANET_OXYGEN],
		[C.PLANET_OCEANS] = self[C.PLANET_OCEANS],
	}
end

function M:get_amount(planet_param_type)
	return self[planet_param_type]
end

function M:increase(planet_param, times)
	times = times or 1
	local increase_value = (planet_param == C.PLANET_TEMPERATURE and 2) or 1

	for i = 1, times do
		local new_value = self[planet_param] + increase_value
		if new_value <= MAX_VALUES[planet_param] then
			self[planet_param] = new_value
			for _, trigger in ipairs(self.triggers or {}) do
				trigger:trigger_if_equal(planet_param, self[planet_param])
			end
			EVENT_REGISTRY.notify(C.INCREASE_TERRAFORM_RATING)
		else
			print("planet param", planet_param, "already at max value")
		end
	end
end

function M:set_triggers(...)
	local list = { ... }
	self.triggers = list -- TODO add validation for list
end

return M
