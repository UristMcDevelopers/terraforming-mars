local test_subject = require "utils.helpers"

return function()

	describe("tesing utils function array_has_value", function()
		test("insert value and assert its present, assert another value is not present", function()
			local a_table = {}
			table.insert(a_table, 1)
			assert(test_subject.array_has_value(a_table, 1))
			assert(not test_subject.array_has_value(a_table, 2))

			table.insert(a_table, "test")
			assert(test_subject.array_has_value(a_table, "test"))
			assert(not test_subject.array_has_value(a_table, "not test"))

			a_table["key"] = "value"
			assert(not test_subject.array_has_value(a_table, "value"))
		end)
	end)
end