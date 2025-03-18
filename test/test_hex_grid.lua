local test_subject = require "hex_grid.hex_grid_utils"

return function()

	describe("hex grid helper functions test cases", function()
		test("assert coordinate by pixel positions", function()
			local size = 50
			local col, row = test_subject.pixel_to_even_r_hex_coordinates(0, 0, size)
			assert(col == 1)
			assert(row == 1)

			col, row = test_subject.pixel_to_even_r_hex_coordinates(size + size / 2, 0, size)
			assert(col == 2)
			assert(row == 1)

			col, row = test_subject.pixel_to_even_r_hex_coordinates(- size, 0, size)
			assert(col == 0)
			assert(row == 1)
		end)
		
		test("test direction differences odd", function()
			local target_row = 5
			local target_column = 5
			local empty_around = {	[target_row] = {[target_column] = "tile" }}
			local coords = {
				[target_row] = {
					[4] = "tile", 
					[target_column] = "tile", 
					[6] = "tile",
				}, 
				[4] = {
					[5] = "tile", 
					[6] = "tile",
				}, 
				[6] = {
					[5] = "tile", 
					[6] = "tile",
				} 
			}
			
			local tiles = test_subject.neighbor_tiles(empty_around, target_row, target_column)
			assert(#tiles == 0, "expecting 0 tiles around 5,5 coords is returned")

			tiles = test_subject.neighbor_tiles(coords, target_row, target_column)
			assert(#tiles == 6, "expecting all tiles around 5,5 coords is returned")
		end)
		
		test("test direction differences even", function()
			local target_row = 6
			local target_column = 6
			local empty_around = {	[target_row] = {[target_column] = "tile" }}
			local coords = {
				[5] = {
					[5] = "tile", 
					[6] = "tile",
				},
				[target_row] = {
					[5] = "tile", 
					[target_column] = "tile",
					[7] = "tile",
				},
				[7] = {
					[5] = "tile", 
					[6] = "tile",
				} 
			}

			local tiles = test_subject.neighbor_tiles(empty_around, target_row, target_column)
			assert(#tiles == 0, "expecting 0 tiles around 6,6 coords is returned")

			tiles = test_subject.neighbor_tiles(coords, target_row, target_column)
			assert(#tiles == 6, "expecting all tiles around 6,6 coords is returned")
		end)
	end)
end