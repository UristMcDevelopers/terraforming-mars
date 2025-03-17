local M = {}

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
M.PLANET_PARAMETERS = "planet_parameters"

M.TILE_TYPE_EMPTY = "tile_type_empty"
M.TILE_TYPE_EMPTY_OCEAN = "tile_type_empty_ocean"
M.TILE_TYPE_CITY = "tile_type_city"
M.TILE_TYPE_TREE = "tile_type_tree"
M.TILE_TYPE_OCEAN = "tile_type_ocean"
M.TILE_TYPE_SPECIAL = "tile_type_special"

M.PLAYER_TERRAFORM_RATING = "terraform_rating"
M.PLAYER_INCOME_CHANGED = "income_changed"
M.PLAYER_RECOURCES_CHANGED = "recources_changed"
M.PLAYER_SPEND_ACTION = "spend_action"
M.PLAYER_SKIP_TURN = "skip_turn"
M.PLAYER_MAP_CLICKED = "map_clicked"
M.PLAYER_DRAW_CARD = "draw_card"

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

M.SHOW_SKIP_TURN_BUTTON = "show_skip_button"
M.SHOW_NEXT_ROUND_BUTTON = "show_next_round_button"
M.UI_STATE_SET_ACTIONS = "ui_state_set_actions"

M.REGISTRY = "registry" -- custom event used for regestry in any component to receive events from it 


return M