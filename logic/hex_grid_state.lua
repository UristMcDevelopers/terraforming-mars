local UTILS = require("utils.helpers")
local GRID_UTILS = require "hex_grid.hex_grid_utils"
local C = require "utils.message_ids"
local EVENT_REGISTRY = require("utils.event_regisrty")

local M = {}

-- TODO вынести в файл все координаты и ресурс
local default_ocean_coords = {[1] = {7}, [4] = {7,8,9}, [5] = {4,5,6}, [6] = {9}, [8] = {8}, [9] = {4,6,7}}
local default_non_mars_coords = {[8] = {1}, [9] = {1}}
local default_noctis_city = {[5] = {3}}
local default_placement_bonuses_coords = {
	[1] = { 
		[3] = { C.RECOURCE_STEEL },
		[4] = { C.RECOURCE_STEEL, C.RECOURCE_STEEL },
		[7] = { C.RECOURCE_TITANIUM, C.RECOURCE_TITANIUM },
	},
	[2] = {
		[3] = { C.RECOURCE_STEEL, C.RECOURCE_STEEL },
		[5] = { C.PLAYER_DRAW_CARD },
		[6] = { C.PLAYER_DRAW_CARD },
		[8] = { C.RECOURCE_TITANIUM },
	},
	[3] = {
		[7] = { C.RECOURCE_PLANT, C.RECOURCE_PLANT },
	},
	[4] = {
		[2] = { C.RECOURCE_PLANT },
		[3] = { C.RECOURCE_PLANT, C.RECOURCE_PLANT },
		[4] = { C.RECOURCE_PLANT },
		[5] = { C.RECOURCE_PLANT },
		[6] = { C.RECOURCE_PLANT },
		[7] = { C.RECOURCE_PLANT },
		[8] = { C.RECOURCE_PLANT },
		[9] = { C.RECOURCE_PLANT },
	},
	[5] = {
		[1] = { C.RECOURCE_PLANT, C.RECOURCE_PLANT },
		[2] = { C.RECOURCE_PLANT, C.RECOURCE_PLANT },
		[3] = { C.RECOURCE_PLANT, C.RECOURCE_PLANT },
		[4] = { C.RECOURCE_PLANT, C.RECOURCE_PLANT },
		[5] = { C.RECOURCE_PLANT, C.RECOURCE_PLANT },
		[6] = { C.RECOURCE_PLANT, C.RECOURCE_PLANT },
		[7] = { C.RECOURCE_PLANT, C.RECOURCE_PLANT },
		[8] = { C.RECOURCE_PLANT, C.RECOURCE_PLANT },
		[9] = { C.RECOURCE_PLANT, C.RECOURCE_PLANT },
	},
	[6] = {
		[2] = { C.RECOURCE_PLANT, C.RECOURCE_STEEL },
		[3] = { C.RECOURCE_PLANT },
		[4] = { C.RECOURCE_PLANT },
		[5] = { C.RECOURCE_PLANT },
		[6] = { C.RECOURCE_PLANT },
		[7] = { C.RECOURCE_PLANT },
		[8] = { C.RECOURCE_PLANT },
		[9] = { C.RECOURCE_PLANT, C.RECOURCE_PLANT },
	},
	[7] = { 
		[2] = { C.PLAYER_DRAW_CARD },
		[8] = { C.RECOURCE_STEEL },
	},
	[8] = { 
		[4] = { C.RECOURCE_STEEL },
		[8] = { C.PLAYER_DRAW_CARD, C.PLAYER_DRAW_CARD },
	},
	[9] = { 
		[3] = { C.RECOURCE_STEEL, C.RECOURCE_STEEL },
		[4] = { C.RECOURCE_STEEL, C.RECOURCE_STEEL },
		[6] = { C.PLAYER_DRAW_CARD },
	},
}

function M.new()
	return setmetatable({
		placed_tiles_coords = {},
		ocean_coords = default_ocean_coords,
		non_mars_coords = default_non_mars_coords,
		noctis_city = default_noctis_city,
		placement_bonuses_coords = default_placement_bonuses_coords,
	}, { __index = M })
end

local function send_tile_bonus_resources(self, row, column)
	local bonus_coords = self:get_placement_bonuses_coords()
	local bonuses_on_tile = (bonus_coords[row] and bonus_coords[row][column]) or {}
	for _, recource_type in ipairs(bonuses_on_tile) do
		if recource_type == C.PLAYER_DRAW_CARD then
			EVENT_REGISTRY.notify(C.PLAYER_DRAW_CARD)
		else
			EVENT_REGISTRY.notify(C.PLAYER_RESOURCES_CHANGED, { current_change = {[recource_type] = 1 } })
		end
	end
end

function M:render_map_recources()
	pprint("render_map_recources", self.placement_bonuses_coords)
	for row_index, column_indexes in pairs(self.placement_bonuses_coords) do
		for column_index, resource_list in pairs(column_indexes) do
			if #resource_list > 0 then
				EVENT_REGISTRY.notify(C.MAP_SET_TILE_RECOURCES, {
					row = row_index,
					column = column_index,
					resources = resource_list
				})
			end
		end
	end
end

function M:render_map_oceans()
	for row_index, column_indexes in pairs(self.ocean_coords) do
		for k, column_index in pairs(column_indexes) do
			EVENT_REGISTRY.notify(C.MAP_SET_TILE, {
				tile_type = C.TILE_TYPE_EMPTY_OCEAN,
				row = row_index, 
				column = column_index, 
				player_color = C.TRANSPARENT_COLOR
			})
		end
	end
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

function M:get_placement_bonuses_coords()
	return self.placement_bonuses_coords or {}
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

	self:update_placed_tiles(row, column, player, tile_type)

	if close_oceans > 0 then
		print("neigbor oceans", close_oceans)
		EVENT_REGISTRY.notify(C.PLAYER_RESOURCES_CHANGED, { current_change = {[C.RECOURCE_GOLD] = (close_oceans * 2) }})
	end
	
	send_tile_bonus_resources(self, row, column) 
end

return M