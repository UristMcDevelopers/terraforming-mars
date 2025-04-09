local component = require("druid.component")

---@class component_name: druid.base_component
local M = component.create("card")

function M:init(template, nodes)
	self.druid = self:get_druid(template, nodes)
	self.root = self:get_node("root")
end

return M