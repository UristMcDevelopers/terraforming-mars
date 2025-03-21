local M = {}

function M.new(actions)
	local init_actions = actions or { true, true }
	return setmetatable({
		actions = init_actions,
		ends_his_turn = false,
	}, { __index = M })
end

function M:skip_turn()
	if self.actions[1] == true and self.actions[2] == true then
		self.ends_his_turn = true
	end
end

function M:spend_action()
	if self.actions[1] == false and self.actions[2] == false then
		error("player played action but he doesn't have one")
	elseif self.actions[1] == false and self.actions[2] == true then
		self.actions[2] = false
	else 
		self.actions[1] = false
	end
end

function M:on_next_round()
	self.actions = { true, true }
	self.ends_his_turn = false
end

function M:has_action()
	return self.actions[1] or self.actions[2]
end

function M:get_actions()
	return self.actions
end

return M