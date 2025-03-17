local UTILS = require("utils.helpers")
local GRID_UTILS = require "hex_grid.hex_grid_utils"
local C = require "utils.message_ids"

local M = {}

function M.new()
	return setmetatable({
		placed_tiles_coords = {},
		ocean_coords = {},
		non_mars_coords = {},
		noctis_city = {},
		placement_bonuses_coords = {},
	}, { __index = M })
end

function M:set_placed_tiles_coords(coords)
	self.placed_tiles_coords = coords
end

function M:set_ocean_coords(coords)
	self.ocean_coords = coords
end

function M:set_non_mars_coords(coords)
	self.non_mars_coords = coords
end

function M:set_noctis_city(coords)
	self.noctis_city = coords
end

function M:set_placement_bonuses_coords(coords)
	self.placement_bonuses_coords = coords
end


function M:is_ocean_place(row, column)
	return self.ocean_coords[row] and UTILS.array_has_value(self.ocean_coords[row], column)
end

function M:is_tile_outside_of_mars_zone(row, column)
	return self.non_mars_coords[row] and UTILS.array_has_value(self.non_mars_coords[row], column)
end

function M:is_city_place(row, column)
	return self.noctis_city[row] and UTILS.array_has_value(self.noctis_city[row], column)
end

function M:is_tile_taken(row, column)
	return self.placed_tiles_coords[row] and self.placed_tiles_coords[row][column]
end


function M:update_placed_tiles(row, column, player, tile_type)
	local row_talbe = self.placed_tiles_coords[row]
	local tile_info = { player = player, type = tile_type }
	if row_talbe == nil then
		self.placed_tiles_coords[row] = { [column] = tile_info }
	else 
		row_talbe[column] = tile_info
	end
end

function M:neighbor_tiles_count(row, column)
	if self:is_city_place(row, column) then
		return 0, 0
	end
	local cities = 0
	local oceans = 0
	local tiles = GRID_UTILS.neighbor_tiles(self.placed_tiles_coords, row, column)
	for i, tile_info in pairs(tiles) do
		if tile_info.type == C.TILE_TYPE_CITY then
			cities = cities + 1
		elseif tile_info.type == C.TILE_TYPE_OCEAN then
			oceans = oceans + 1
		end
	end
	return cities, oceans
end

-- TODO think on how to use it and properly validate tile placement actions 
-- TODO what proper idea of how to return error
--maybe just disable tiles where player can't place tile due to rules violations
-- TODO think on how to return events to send 
function M:set_with_validation(row, column, player, tile_type)
	if self:is_tile_taken(row, column) then
		error("tile is already taken")
	end
	local close_cities, close_oceans = self:neighbor_tiles_count(row, column)
	if tile_type ~= C.TILE_TYPE_OCEAN and self:is_ocean_place(row, column) then
		error("only ocean on ocean tile")
	end
	if tile_type == C.TILE_TYPE_OCEAN and not self:is_ocean_place(row, column) then
		error("ocean can be placed only in ocean tile")
	end
	if tile_type ~= C.TILE_TYPE_CITY and self:is_tile_outside_of_mars_zone(row, column) then
		error("only city on this tile")
	end
	if tile_type == C.TILE_TYPE_CITY and not self:is_tile_outside_of_mars_zone(row, column) then
		if close_cities > 0 then
			error("has neigbor city")
		end
	end		
	if close_oceans > 0 then
		print("neigbor oceans", close_oceans)
		-- TODO send 2 gold per tile to player who put tile
	end

	self:update_placed_tiles(row, column, player, tile_type)
end

return M