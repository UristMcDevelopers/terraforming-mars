local EVENT_DATA_QUEUE = require("utils.event_data_queue")

local M = {}

local registry = {}
local large_message_registry = {}

function M.registry(topic, reciever)
	assert(topic)
	local recievers = registry[topic] or {}
	table.insert(recievers, reciever)
	registry[topic] = recievers
end

--work around for message size
function M.registry_for_large_message(topic, reciever)
	assert(topic)
	local recievers = large_message_registry[topic] or {}
	table.insert(recievers, reciever)
	large_message_registry[topic] = recievers
end

function M.notify(topic, data)
	data = data or {}
	for _, receiver in ipairs(registry[topic] or {}) do
		pprint("notify", topic,  "receiver", receiver, "from", msg.url(), "notify data", data)
		msg.post(receiver, topic, data)
	end
end

function M.notify_with_large_message(topic, data)
	if data then
		EVENT_DATA_QUEUE.push(topic, data)
	end
	for _, receiver in ipairs(large_message_registry[topic] or {}) do
		pprint("notify", topic,  "receiver", receiver, "from", msg.url())
		msg.post(receiver, topic)
	end
end


return M