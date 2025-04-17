local M = {}

function M.new(name, description, cost)
	return setmetatable({
		id = rnd.range(1, 2147483647),
		name = name,
		description = description,
		cost = cost,
		card_type = "",
		tags = {},
		requirement = {
			resource_type = "",
			more_or_equal = 1,
			less_or_equal = 1,
		},
		effects = {},
		tokens_on_card = {},
		-- score = { --this part only for multiplayer
		-- 	score_type = "", --fixed or calcucatable
		-- 	score = 1,
		-- 	calcucate = {
		-- 		per = "", --token, city
		-- 		per_amount = 1,
		-- 	}
		-- },
		
		
	}, { __index = M })
end

return M