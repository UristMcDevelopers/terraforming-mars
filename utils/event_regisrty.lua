local C = require "utils.message_ids"

local M = {}

local registry = {}

function M.registry(topic, reciever)
	assert(topic)
	local recievers = registry[topic] or {}
	table.insert(recievers, reciever)
	registry[topic] = recievers
end

function M.get_by_topic(topic)
	return registry[topic] or {}
end

function M.notify(topic, data)
	data = data or {}
	for index, receiver in ipairs(M.get_by_topic(topic)) do
		print("notify", topic,  "receiver", receiver)
		msg.post(receiver, topic, data)
	end
end

return M