local M = {}

function M.array_has_value(tabel, val)
	for index, value in ipairs(tabel) do
		if value == val then
			return true
		end
	end

	return false
end

function M.is_sprite_picked(sprite_url, x, y)
	local size = go.get(sprite_url, "size")
	local pos = go.get_position(sprite_url)
	local half_length = size.x / 2
	local half_height = size.y / 2
	local left = pos.x - half_length
	local right = pos.x + half_length
	local top = pos.y + half_height
	local bottom = pos.y - half_height
	return x > left and x < right and y > bottom and y < top 
end

return M