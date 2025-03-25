local M = {}

function M.new()
	return setmetatable({
		nodes = {},
		on_click = function (clicked_node) end,
		
	}, { __index = M })
end

function M:initial_position(vector3)
	self.init_pos = vector3
end

function M:set_script_name(script_name)
	self.script_name = script_name
end

function M:set_height_of_node(wanted_height)
	self.wanted_height = wanted_height 
end

function M:set_size(x, y)
	self.row_size = x
	self.column_size = y
end

function M:set_factory_name(factory)
	self.factory = factory
end


function M:on_node_click(callback)
	self.on_click = callback
end

function M:spawn(list_of_data)
	assert(self.script_name)
	assert(self.wanted_height)
	assert(self.row_size)
	assert(self.column_size)
	assert(self.factory)
	assert(list_of_data)
	assert(#list_of_data > 0)
	
	self.nodes = {}
	local dummy_id = factory.create(self.factory, vmath.vector3(0, 0, 0), nil, nil, self.scale)
	local dummy_url = msg.url(nil, dummy_id, self.script_name)
	local size = go.get(dummy_url, "size") -- expecting to have property named "size"
	go.delete(dummy_id)

	self.size_of_node = size
	self.scale = self.wanted_height / size.y
	self.init_pos = self.init_pos or go.get_position()
	local spawned = 0
	for col_index = 1, self.column_size do
		for row_index = 1, self.row_size do
			if spawned == #list_of_data then
				break
			end
			
			local x = self.size_of_node.x * (row_index - 1) * self.scale
			local y = self.size_of_node.y * (col_index - 1) * self.scale
			local new_pos = self.init_pos + vmath.vector3(x, -y, 0)
			local data = list_of_data[spawned + 1] or {}
			local node_id = factory.create(self.factory, new_pos, nil, nil, self.scale)
			msg.post(msg.url(nil, node_id, self.script_name), "set", data)
			print(new_pos)
			local to_corner_vector = self.size_of_node * self.scale / 2
			self.nodes[node_id] = {
				data = data, 
				pos = new_pos, 
				bottom_left = new_pos - to_corner_vector, 
				top_right = new_pos + to_corner_vector
			}

			spawned = spawned + 1
		end
	end
end

function M:get_clicked_node(x, y)
	for node_id, node_content in pairs(self.nodes) do
		if node_content.bottom_left.x < x and node_content.top_right.x > x and
		node_content.bottom_left.y < y and node_content.top_right.y > y then
			return node_content.data
		end
	end
	return nil
end


function M:on_input(x, y)
	local clicked_node = self:get_clicked_node(x,y)
	if clicked_node then
		pcall(self.on_click, clicked_node)
	end
end

function M:clear()
	for node_id, node_content in pairs(self.nodes) do
		go.delete(node_id)
	end
	self.nodes = {}
end

return M