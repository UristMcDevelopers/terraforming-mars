local component = require("druid.component")

---@class component_name: druid.base_component
local M = component.create("playble_action")

function M:init(template, nodes)
	print("template from playble_action" .. (template or "nil"))
	self.druid = self:get_druid(template, nodes)
	self.root = self:get_node("root")
end

return M