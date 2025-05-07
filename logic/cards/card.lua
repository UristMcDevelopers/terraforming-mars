local E = require("logic.action_effect")
local resource_type = require("logic.enums.resource_type")
local tag_type = require("logic.enums.tag_type")
local planet_param_type = require("logic.enums.planet_param_type")
local _requirements = require("logic.requirements")

local M = {}

function M.new(name, description, cost, effects)
	return setmetatable({
		id = rnd.range(1, 2147483647),
		name = name,
		description = description,
		cost = cost,
		card_type = "",
		tags = {},
		requirements = { {
			_type = "",
			resource_type = "",
			more_or_equal = 1,
			less_or_equal = 1,
		} },
		effects = effects,
		tokens_on_card = {},
		-- score = { --this part only for multiplayer
		-- 	score_type = "", --fixed or calcucatable
		-- 	score = 1,
		-- 	calcucate = {
		-- 		per = "", --token, city
		-- 		per_amount = 1,
		-- 	}
		-- },
	}, { __index = M })
end

function M.cast(card)
	card = setmetatable(card, { __index = M })
	card.id = rnd.range(1, 2147483647)
	return card
end

---returns self
function M:set_requirements(requirements)
	self.requirements = requirements
	return self
end

--- TEST GREEN CARDS
function M.test_card_income()
	return M.new("Acquired Company", "Increase your M€ production 3 steps.", 10, {
		E.increase_income(resource_type.GOLD, 3),
	})
end

function M.test_card_requires_3_different_tags()
	return M.new("Advanced Ecosystems", "Requires a plant tag, a microbe tag, and an animal tag.", 11, {
		E.increase_income(resource_type.GOLD, 3),
	}):set_requirements({
		_requirements.new_by_tag(tag_type.PLANT, 1),
		_requirements.new_by_tag(tag_type.MICROBE, 1),
		_requirements.new_by_tag(tag_type.ANIMAL, 1),
	})
end

function M.test_card_requires_5_oceans()
	return M.new("Algae", "Requires 5 ocean tiles. Gain 1 plant and increase your plant production 2 steps.", 10, {
		E.increase_income(resource_type.GOLD, 3),
	}):set_requirements({ _requirements.new_by_planet_param_more(planet_param_type.OCEANS, 5) })
end

function M.test_card_place_ocean_at_not_ocean_place()
	return M.new(
		"Artificial Lake",
		"Requires -6 C or warmer. Place 1 ocean tile ON AN AREA NOT RESERVED FOR OCEAN.",
		15,
		{
			--TODO implement how to place ocean in non ocean place
		}
	)
		:set_requirements({ _requirements.new_by_planet_param_more(planet_param_type.TEMPERATURE, -6) })
end

function M.test_card_income_choice()
	return M.new(
		"Artificial Photosynthesis",
		"Increase your plant production 1 step or your energy production 2 steps.",
		12,
		{
			--TODO it's not gonna work right now
			E.give_choice_beatween({
				E.increase_income(resource_type.PLANT, 1),
				E.increase_income(resource_type.ELECTRICITY, 2),
			}),
		}
	)
end

function M.test_card_requires_titanium_income()
	return M.new(
		"Asteroid Mining Consortium",
		"Requires that you have titanium production. Decrease any titanium production 1 step and increase your own 1 step.",
		13,
		{
			--TODO it's not gonna work right now
			E.increase_income(resource_type.PLANT, 1),
			E.increase_income(resource_type.TITANIUM, 1),
		}
	):set_requirements({ _requirements.new_by_rescource_income(resource_type.TITANIUM, 1) })
end

--- TEST BLUE CARDS

function M.test_card_adaptation_technology()
	return M.new(
		"Adaptation Technology",
		"Effect: Your global requirements are +2 or -2 steps, your choice in each case.",
		12,
		{
			--TODO implement as buff for player
		}
	)
end

--- TEST RED CARDS

return M

