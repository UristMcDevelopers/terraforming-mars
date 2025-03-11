--thanks to https://www.redblobgames.com/grids/hexagons/#coordinates-cube
-- only support even-r grid
local M = {}

local direction_differences = {
	-- even rows 
	{{1, -1}, {1,  0}, 
	{ 0, -1}, { 0, 1}, 
	{-1,  -1}, {-1, 0}},
	-- odd rows 
	{{1,  0}, { 1, 1}, 
	{0, -1}, {0,  1}, 
	{-1, 0}, { -1, 1}},
}

local function axial_to_cube(q, r)
	local s = -q-r
	return q, r, s
end

local function round(x)
	return x >= 0 and math.floor(x + 0.5) or math.ceil(x - 0.5)
end

local function cube_to_axial(cube_q, cube_r, cube_s)
	return cube_q, cube_r
end

local function cube_round(cube_q, cube_r, cube_s)
	local q = round(cube_q)
	local r = round(cube_r)
	local s = round(cube_s)

	local q_diff = math.abs(q - cube_q)
	local r_diff = math.abs(r - cube_r)
	local s_diff = math.abs(s - cube_s)

	if q_diff > r_diff and q_diff > s_diff then
		q = -r-s
	elseif r_diff > s_diff then
		r = -q-s
	else
		s = -q-r
	end
	return q, r, s
end

local function axial_to_evenr(q, r)
	local col = q + (r + (r % 2)) / 2
	local row = r
	return col, row
end

local function axial_round(q, r)
	return axial_to_evenr(cube_to_axial(cube_round(axial_to_cube(q, r))))
end

function M.pixel_to_even_r_hex_coordinates(click_x, click_y, size)
	local q = (math.sqrt(3)/3 * click_x  -  1/3 * click_y) / size
	local r = (                        		2/3 * click_y) / size
	local col, row = axial_round(q, r)
	-- to lua indexes (which starts from 1)
	col = col + 1
	row = row + 1
	return col, row 
end

function M.row_even_offset(row_index, horizontal_spacing)
	if row_index % 2 == 0 then
		return horizontal_spacing / 2
	end
	return 0
end

function M.neighbor_tiles(placed_tiles_coords, row, column)
	local tiles = {}
	local index = row % 2 == 0 and 1 or 2
	for i, r_c_index in ipairs(direction_differences[index]) do
		local columns = placed_tiles_coords[row + r_c_index[1]]
		if columns ~= nil then
			local tile_info = columns[column + r_c_index[2]]
			if tile_info ~= nil then
				table.insert(tiles, tile_info)
			end
		end
	end
	return tiles
end

return M