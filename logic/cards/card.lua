local M = {}

function M.new(name, description, cost)
	return setmetatable({
		id = rnd.range(1, 2147483647),
		name = name,
		description = description,
		cost = cost,
	}, { __index = M })
end

return M