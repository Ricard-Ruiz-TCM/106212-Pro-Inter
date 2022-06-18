-- /////////////////////////////////////////////////////////////////////////////////
-- -------------------------------------------------------------------------- NODES
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

minetest.register_node("teleport:base", {
	description = "Base for Teleports",
	tiles = {"teleport_base.png"},
	groups = {crumbly = 3, soil = 1},
    after_place_node = function(pos, node, player, pointed_thing)
        local player = minetest.get_player_by_name("singleplayer")
        local inv = player:get_inventory()
        local stack = ItemStack("teleport:command 1")
        local meta = stack:get_meta()
        meta:set_int("x", pos.x)
        meta:set_int("y", pos.y)
        meta:set_int("z", pos.z)
        local leftover = inv:add_item("main", stack)
    end    
})

-- /////////////////////////////////////////////////////////////////////////////////
-- ---------------------------------------------------------------------- MATERIALS
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

minetest.register_craftitem("teleport:command", {
    description = "Teleport command",
    inventory_image = "teleport_command.png",
    on_use = function(itemstack, user, pointed_thing)
            local meta = itemstack:get_meta()
            local pos = {x=meta:get_int("x"), y=meta:get_int("y") + 1, z=meta:get_int("z")}
            local player = minetest.get_player_by_name("singleplayer")
            player:set_pos(pos)
        end
})




