local M = {}

-- Data

M.TRANSPARENT_COLOR = vmath.vector4(0, 0, 0, 0)
M.NON_PLAYER_COLOR = vmath.vector4(1, 1, 1, 1)
M.PLAYER_1_COLOR = vmath.vector4(1, 0, 0, 1)
M.PLAYER_2_COLOR = vmath.vector4(0, 1, 0, 1)
M.PLAYER_3_COLOR = vmath.vector4(0, 0, 1, 1)
M.PLAYER_4_COLOR = vmath.vector4(1, 1, 0, 1)

M.RECOURCE_GOLD = "gold"
M.RECOURCE_STEEL = "steel"
M.RECOURCE_TITANIUM = "titanium"
M.RECOURCE_PLANT = "plant"
M.RECOURCE_ELECTRICITY = "electricity"
M.RECOURCE_HEAT = "heat"

M.PLANET_OXYGEN = "oxygen"
M.PLANET_TEMPERATURE = "temperature"
M.PLANET_OCEANS = "oceans"

M.TILE_TYPE_EMPTY = "tile_type_empty"
M.TILE_TYPE_EMPTY_OCEAN = "tile_type_empty_ocean"
M.TILE_TYPE_CITY = "tile_type_city"
M.TILE_TYPE_TREE = "tile_type_tree"
M.TILE_TYPE_OCEAN = "tile_type_ocean"
M.TILE_TYPE_SPECIAL = "tile_type_special"

-- State events
M.PLAYER_TERRAFORM_RATING = "terraform_rating"
M.PLAYER_RESOURCES_CHANGED = "PLAYER_RESOURCES_CHANGED"
M.PLAYER_SKIP_TURN = "skip_turn"
M.PLAYER_DRAW_CARD = "draw_card"
M.PLAYER_CHOSE_ACTION_TO_PLAY = "PLAYER_CHOSE_ACTION_TO_PLAY"
M.PLAYER_CHOSE_CARD_TO_PLAY = "PLAYER_CHOSE_CARD_TO_PLAY"

M.TAKE_MILESTONE_OR_AWARD = "take_milestone_or_award"
M.MILESTONE_TERRAFORMER = "milestone_terraformer"
M.MILESTONE_MAYOR = "milestone_mayor"
M.MILESTONE_GARDENER = "milestone_gardener"
M.MILESTONE_BUILDER = "milestone_builder"
M.MILESTONE_PLANNER = "milestone_planner"
M.AWARD_LANDLORD = "award_landlord"
M.AWARD_BANKER = "award_banker"
M.AWARD_SCIENTIST = "award_scientist"
M.AWARD_THERMALIST = "award_thermalist"
M.AWARD_MINER = "award_miner"

M.MAP_SET_TILE = "map_set_tile"
M.MAP_SET_TILE_RECOURCES = "map_set_tile_recources"
M.MAP_SET_CLICKABLE = "map_set_clickable"
M.MAP_TILE_PLACED = "map_tile_placed"

M.INCREASE_TERRAFORM_RATING = "INCREASE_TERRAFORM_RATING"
M.INCREASE_PLANET_PARAMETER = "INCREASE_PLANET_PARAMETER"

-- UI events
M.GIVE_PLAYER_TO_PLACE_TILE = "GIVE_PLAYER_TO_PLACE_TILE"
M.UI_STATE_SET_ACTIONS = "ui_state_set_actions"
M.UI_CLICK_AVAILABLE_ACTIONS = "UI_CLICK_AVAILABLE_ACTIONS"
M.UI_CLICK_HAND = "UI_CLICK_HAND"
M.UI_SHOW_ACTIONS_GRID = "UI_SHOW_ACTIONS_GRID"
M.UI_SHOW_HAND = "UI_SHOW_HAND"
M.UI_UPDATE_MILESTONES_AWARDS = "UI_UPDATE_MILESTONES_AWARDS"
M.UI_UPDATE_PLANET_PARAMETERS = "UI_UPDATE_PLANET_PARAMETERS"
M.UI_UPDATE_RESOURCES = "UI_UPDATE_RESOURCES"

-- System events
M.HEX_GRID_COMPONENT_LOADED = "HEX_GRID_COMPONENT_LOADED"

M.REGISTRY = "registry" -- custom event used for regestry in any component to receive events from it 


return M