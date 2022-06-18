minetest.register_node("mymod:mynode", {
    description = "My node",
    tiles = {"mymod_mynode.png"},
    groups = {cracky=3}
})

minetest.register_craftitem("mymod:myitem", {
    description = "My Item",
    inventory_image = "mymod_myitem.png"
})

minetest.register_craft({
    output = "mymod:mytool",
    recipe = {
        {"mymod:myitem", ""},
        {"mymod:myitem","mymod:myitem"},
        {"mymod:myitem","mymod:myitem"}
    }
})

minetest.register_tool("mymod:mytool", {
    description = "My Tool",
    inventory_image = "mymod_mytool.png",
    tool_capabilities = {
        full_punch_interval = 1.5,
        max_drop_level = 1,
        groupcaps = {
            crumbly = {
                maxlevel = 2,
                uses = 20,
                times = { [1]=1.60, [2]=1.20, [3]=0.80 }
            },
        },
    damage_groups = {fleshy=2},
    },
})

