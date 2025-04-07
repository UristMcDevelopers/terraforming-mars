local M = {}

function M.new(name, desc, spend_effect, get_effect_list, is_standart_project)
	return setmetatable({
		id = rnd.range(1, 2147483647),
		name = name,
		action_name = name,
		available = true,
		is_standart_project = is_standart_project,
		description = desc,
		spend = spend_effect,
		get = get_effect_list,
		
		-- spend = {
		-- 	text = "",
		-- 	type = "NOTHING, RESOURCE, INCOME, RESOURCE_ON_CARD",
		-- 	resource_type = "like steel, microbs",
		-- 	amount = 1,
		-- 	target = "this, other, any"
		-- },
		-- get = {
		-- 	{
		-- 		text = "",
		-- 		type = "RESOURCE, INCOME, PLANET_PARAM, RESOURCE_ON_CARD, CUSTOM_EVENT?",
		-- 		resource_type = "like steel, microbs",
		-- 		amount = 1,
		-- 		target = "this, other, any"
		-- 	}
		-- }
	}, { __index = M })
end

function M:effect_played()
	if not self.is_standart_project then
		self.available = false
	end
end

function M:is_available()
	return self.available
end

return M