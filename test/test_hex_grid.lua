local test_subject = require "hex_grid.hex_grid_utils"

return function()

	describe("asd", function()
		test("asd", function()
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
			local empty_around = {	[5] = {[5] = "tile" }}
			local coords = {
				[5] = {
					[4] = "tile", 
					[5] = "tile", 
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
			
			local tiles = test_subject.neighbor_tiles(empty_around, 5, 5)
			assert(#tiles == 0, "expecting 0 tiles around 5,5 coords is returned")

			tiles = test_subject.neighbor_tiles(coords, 5, 5)
			assert(#tiles == 6, "expecting all tiles around 5,5 coords is returned")
		end)
	end)
end