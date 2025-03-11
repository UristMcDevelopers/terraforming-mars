local M = {}

function M.array_has_value(tabel, val)
	for index, value in ipairs(tabel) do
		if value == val then
			return true
		end
	end

	return false
end

return M