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

function M.value_of_enum(enum, value)
	assert(type(enum) == 'table')
	for enum_key, enum_value in pairs(enum) do
		if value == enum_value then
			return
		end	
	end
	assert(nil, "value is not in enum values")
	
end


return M