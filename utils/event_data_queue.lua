local M = {}

local queue = {}

function M.push(topic, data)
	assert(topic)
	assert(data)
	print("data pushed for", topic)
	local queue_by_topic = queue[topic] or {}
	table.insert(queue_by_topic, data)
	queue[topic] = queue_by_topic
end

--TODO im not shure how it will work for concurrent pop. lets hope im not gonna need it
function M.pop(topic)
	local queue_by_topic = queue[topic]
	if queue_by_topic then
		print("data read for", topic)
		return table.remove(queue_by_topic)
	end
	return nil
end


return M