local M = {}

function M.new(key, value, callback)
	callback = callback or function () print("trigger for key" .. key .. " value " .. value .. " called") end
	return setmetatable({
		callback = callback,
		key = key,
		value = value,
	}, { __index = M })
end

function M:trigger()
	pcall(self.callback)
end

function M:has_key(key)
	if key then
		return key == self.key
	end
	return false
end

function M:has_value(value)
	if value then
		return value == self.value
	end
	return false
end

function M:trigger_if_equal(key, value)
	if self:has_key(key) and self:has_value(value) then
		self:trigger()
	end
end

return M