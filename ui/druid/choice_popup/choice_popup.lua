local UTILS = require("utils.helpers")
local component = require("druid.component")
local playble_action = require("ui.druid.playble_action.playble_action")
local card_component = require("ui.druid.card.card")
local const = require("druid.const")

local M = component.create("choice_popup")

local PREFAB_CARD_NODE_NAME = "card_grid_content"
local PREFAB_ACTION_NODE_NAME = "playble_action_grid_content"
local SCROLL_VIEW_ZONE = "scrollable_grid_view"

-- Usage of component:
-- This component will delete itself from druid after "work" is done
-- so you need to recreate it with this two lines
-- if self.choice_popup:is_deleted() then
-- self.choice_popup = self.druid:new(choice_popup, "choice_popup")

-- Must be set:
-- :on_confirm function to recieve result of choice (node list)
-- :set_actions or :set_cards(not supported now) based on what you want to show to player

-- Additional features:
-- set_multi_choice(bool) - default - false. On true - more then one node can be choosen and will be returned on 'Confirm' button click 

function M:init(template, nodes)
	self.deleted = false
	self.created_nodes = {}
	self.selected_nodes = {}

	self.druid = self:get_druid(template, nodes)
	self.root = self:get_node("root")
	self.background_node = self:get_node("background")
	self.confirm_button = self:get_node("confirm_button/button")
	self.on_confirm_cb = nil
	self.on_outside_cb = function ()  end
	gui.set_enabled(self.root, true)
	gui.set_enabled(self.confirm_button, false)

	local background_as_button = self.druid:new_button(self.background_node, function () end)
	background_as_button.hover:set_enabled(false)
	background_as_button.style.on_click = function () end
	background_as_button.on_click_outside:subscribe(function () 
		pcall(self.on_cancel_cb)
		self:clear()
	end)

	-- workaround. Sooooo on self.druid:remove(self) we deliting confirm button from druid too
	-- but animation of click is not ended. so it's removed at the moment its scaled a bit, (for click feel) 
	-- and never returns to normal scale (the over way is to create button from dummy object)
	gui.set_scale(self.confirm_button, vmath.vector3(1, 1, 1)) -- 
end

local function confirm_selected_nodes(self)
	if #self.selected_nodes == 0 then
		print("empty choice")
		return
	end
	pcall(self.on_confirm_cb, self.selected_nodes)
	self:clear()
end

local function on_action_click(self, clicked_node, box_node_name)
	if self.multi_choice then
		if not UTILS.array_has_value(self.selected_nodes, clicked_node) then
			pprint("add to selected nodes", clicked_node)
			--TODO add select effect via shader or texture swap
			table.insert(self.selected_nodes, clicked_node)
		end
	else
		pprint("sending single selected node", clicked_node)
		table.insert(self.selected_nodes, clicked_node)
		confirm_selected_nodes(self)
	end
end

function M:set_multi_choice(bool)
	self.multi_choice = bool
	gui.set_enabled(self.confirm_button, bool)
	if bool == true then
		self.druid:new_button(self.confirm_button, function () confirm_selected_nodes(self)	end)
	end
end

function M:on_confirm(func_on_selected_nodes)
	self.on_confirm_cb = func_on_selected_nodes
end


function M:on_cancel(func_on_cancel)
	self.on_cancel_cb = func_on_cancel
end

function M:set_actions(actions)
	self.action_dummy = self.druid:new(playble_action, "playble_action")

	-- self.druid:new_button("playble_action/root", function() print("kek") end)
	self.action_prefab = self:get_node("playble_action/root")

	self.scroll = self.druid:new_scroll(SCROLL_VIEW_ZONE, PREFAB_ACTION_NODE_NAME)
	:set_extra_stretch_size(0)
	:set_inert(false)
	self.grid = self.druid:new_static_grid(PREFAB_ACTION_NODE_NAME, self.action_prefab, 1)
	self.scroll:bind_grid(self.grid)

	for index, action in ipairs(actions or {}) do
		self:add_action_element(action)
	end
end

function M:is_deleted()
	return self.deleted
end

function M:add_action_element(action)
	local prefab_nodes = gui.clone_tree(self.action_dummy.root)
	local root = prefab_nodes["choice_popup/playble_action/root"]
	local spend_text = prefab_nodes["choice_popup/playble_action/spend_text"]
	local get_text = prefab_nodes["choice_popup/playble_action/get_text"]
	local button = self.druid:new_button(root, function () on_action_click(self, action, root) end)
	button.hover:set_enabled(false) --TODO disable hover, bacause for some reason hover hides text, and i dont want to investigate it
	
	gui.set_enabled(root, true)
	gui.set_text(spend_text, action.action_name)
	gui.set_text(get_text, action.action_name)
	
	self.grid:add(root)
	table.insert(self.created_nodes, root)
end

function M:clear()
	for _, node in ipairs(self.created_nodes) do
		gui.delete_node(node)
	end

	gui.set_enabled(self.root, false)
	self.deleted = true
	self.druid:remove(self)
end

function M:set_cards(cards)
	self.card_dummy = self.druid:new(card_component, "card")
	self.card_root = self:get_node("card/root")

	self.scroll = self.druid:new_scroll(SCROLL_VIEW_ZONE, PREFAB_CARD_NODE_NAME)
	:set_extra_stretch_size(0)
	:set_inert(false)
	self.grid = self.druid:new_static_grid(PREFAB_CARD_NODE_NAME, self.card_root, 2)
	self.scroll:bind_grid(self.grid)

	for index, card in ipairs(cards or {}) do
		self:add_card_element(card)
	end
end

function M:add_card_element(card)
	local prefab_nodes = gui.clone_tree(self.card_dummy.root)
	local root = prefab_nodes["choice_popup/card/card_data"]
	local card_name = prefab_nodes["choice_popup/card/card_name"]
	local card_cost = prefab_nodes["choice_popup/card/card_cost/text_cost"]
	local card_description = prefab_nodes["choice_popup/card/card_description"]
	self.druid:new_button(root, function () on_action_click(self, card, root) end) --TODO change function to give player resource distribution choice

	-- gui.set_enabled(root, true)
	gui.set_text(card_name, card.name)
	gui.set_text(card_cost, card.cost)
	for index, tag in ipairs(card.tags or {}) do
		local tag_node = prefab_nodes["choice_popup/card/" .. "tag" .. index .."/image_tag"]
		gui.play_flipbook(tag_node, tag)
	end

	gui.set_text(card_description, card.description)
	self.druid:new_text(card_description):set_text_adjust(const.TEXT_ADJUST.DOWNSCALE, 0.5)
	

	self.grid:add(root)
	table.insert(self.created_nodes, root)
end

return M

