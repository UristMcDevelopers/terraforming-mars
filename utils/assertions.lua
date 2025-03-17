local M = {}

function M.assert(value)
	assert(value, "value is nil or false")
end

function M.type_number(value)
	M.assert(value)
	local value_type = type(value)
	assert(value_type == "number", "expected number got " .. value_type)
end

function M.positive_number(value)
	M.assert(value)
	M.type_number(value)
	assert(value > 0, "expected positive number")
end

function M.type_boolean(value)
	local value_type = type(value)
	assert(value_type == "boolean", "expected boolean got " .. value_type)
end

return M