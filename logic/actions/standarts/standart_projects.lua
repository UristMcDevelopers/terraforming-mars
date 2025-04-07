local playable_action = require("logic.playable_action")
local effect = require("logic.action_effect")
local action_effect = require("logic.enums.action_effect_type")
local resource = require("logic.enums.resource_type")
local planet = require("logic.enums.planet_param_type")
local tile = require("logic.enums.tile_type")

local M = {}

--TODO подумать как реализовать продажу патентов
-- function M.new_sell_cards()
-- 	return setmetatable(playable_action.new(
-- 	"Sell patents",
-- 	"Sell patents",
-- 	effect.new(nil, action_effect.SELL_CARDS, nil, nil, nil),
-- 	{ effect.new(nil, action_effect.INCOME, resource.ELECTRICITY, 1, nil) }
-- ), { __index = M })
-- end


function M.new_increase_electicity_income()
	return playable_action.new(
	"Electricity income",
	"Electricity income",
	effect.new(nil, action_effect.RESOURCE, resource.GOLD, -11, nil),
	{ effect.new(nil, action_effect.INCOME, resource.ELECTRICITY, 1, nil) }, 
	true)
end

function M.new_asteroid()
	return playable_action.new(
	"Asteroid",
	"Asteroid",
	effect.new(nil, action_effect.RESOURCE, resource.GOLD, -14, nil),
	{ effect.new(nil, action_effect.PLANET_PARAM, planet.TEMPERATURE, 1, nil) }, 
	true)
end

function M.new_ocean()
	return playable_action.new(
	"Ocean",
	"Ocean",
	effect.new(nil, action_effect.RESOURCE, resource.GOLD, -18, nil),
	{ effect.new(nil, action_effect.PLACE_THE_TILE, tile.OCEAN, 1, nil) }, 
	true)
end

function M.new_tree()
	return playable_action.new(
	"Greenery",
	"Greenery",
	effect.new(nil, action_effect.RESOURCE, resource.GOLD, -23, nil),
	{ effect.new(nil, action_effect.PLACE_THE_TILE, tile.TREE, 1, nil) }, 
	true)
end

function M.new_city()
	return playable_action.new(
	"City",
	"City",
	effect.new(nil, action_effect.RESOURCE, resource.GOLD, -25, nil),
	{ 
		effect.new(nil, action_effect.PLACE_THE_TILE, tile.CITY, 1, nil),
		effect.new(nil, action_effect.INCOME, resource.GOLD, 1, nil)
	}, 
	true
)
end

function M.new_spend_heat()
	return playable_action.new(
	"Spend heat to increase temperature",
	"Spend heat to increase temperature",
	effect.new(nil, action_effect.RESOURCE, resource.HEAT, -8, nil),
	{ effect.new(nil, action_effect.PLANET_PARAM, planet.TEMPERATURE, 1, nil) }, 
	true
)
end

function M.new_spend_plants()
	return playable_action.new(
	"Spend plants to place greenary tile",
	"Spend plants to place greenary tile",
	effect.new(nil, action_effect.RESOURCE, resource.PLANT, -8, nil),
	{ effect.new(nil, action_effect.PLACE_THE_TILE, planet.TREE, 1, nil) }, 
	true
)
end


return M