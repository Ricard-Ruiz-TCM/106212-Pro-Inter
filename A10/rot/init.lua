-- /////////////////////////////////////////////////////////////////////////////////
-- --------------------------------------------------------------------------- ORES
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

minetest.register_node("rot:dirt", {
	description = "Rotted Dirt",
	tiles = {"rot_dirt.png"},
	groups = {crumbly = 3, soil = 1},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_node("rot:purgator", {
	description = "Rotted Dirt Purgator",
	tiles = {"rot_dirt_purgator.png"},
	groups = {crumbly = 3, soil = 1},
	sounds = default.node_sound_dirt_defaults()
})

-- /////////////////////////////////////////////////////////////////////////////////
-- ----------------------------------------------------------------- COMPORTAMIENTO
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

-- Corrompoemos nuestra teirra
minetest.register_abm({
	nodenames = {"default:dirt", "default:dirt_with_grass"},
	interval = 60.0,
	chance = 100,
	catch_up = false,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.set_node(pos, {name = "rot:dirt"})
	end
})

-- Comprobamos los adyacientes para corromperlos
minetest.register_abm({
	nodenames = {"default:dirt", "default:dirt_with_grass"},
	neighbors = {
		"rot:dirt"
	},
	interval = 30.0,
	chance = 50,
	catch_up = false,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.set_node(pos, {name = "rot:dirt"})
	end
})

-- DesCorrompomemos nuestra teirra
minetest.register_abm({
	nodenames = {"rot:dirt"},
	interval = 60,
	chance = 100,
	catch_up = false,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.set_node(pos, {name = "default:dirt"})
	end
})

-- DesCorrompomemos nuestra teirra con el purgador
minetest.register_abm({
	nodenames = {"rot:purgator"},
	interval = 1,
	chance = 1,
	catch_up = false,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local c_dirt = minetest.get_content_id("default:dirt")
		local c_rot_dirt = minetest.get_content_id("rot:dirt")

		local function purge_rotdirt(pos, size)
			-- Read data into LVM
			local vm = minetest.get_voxel_manip()
			local pos1 = {x = pos.x - size, y = pos.y, z = pos.z - 10}
			local pos2 = {x = pos.x + size, y = pos.y, z = pos.z + 10}
			local emin, emax = vm:read_from_map(pos1, pos2)
			local a = VoxelArea:new{ MinEdge = emin, MaxEdge = emax }
			local data = vm:get_data()
			-- Modify data
			for z = pos1.z, pos2.z do
				for y = pos1.y, pos2.y do
					for x = pos1.x, pos2.x do
						local vi = a:index(x, y, z)
						if data[vi] == c_rot_dirt then
							data[vi] = c_dirt
						end
					end
				end
			end
			-- Write data
			vm:set_data(data)
			vm:write_to_map(true)
		end

		purge_rotdirt(pos, 10)
	end
})

