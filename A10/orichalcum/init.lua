-- /////////////////////////////////////////////////////////////////////////////////
-- --------------------------------------------------------------------------- ORES
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

minetest.register_node("orichalcum:orichalcum_ore", {
    description = "Orichalcum Ore",
    tiles = {"orichalcum_ore.png"},
    groups = {cracky=3},
    sounds = default.node_sound_stone_defaults(),
})

-- /////////////////////////////////////////////////////////////////////////////////
-- ---------------------------------------------------------------------- MATERIALS
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

minetest.register_craftitem("orichalcum:orichalcum_lump", {
    description = "Orichalcum Lump",
    inventory_image = "orichalcum_lump.png"
})

minetest.register_craftitem("orichalcum:orichalcum_ingot", {
    description = "Orichalcum Ingot",
    inventory_image = "orichalcum_ingot.png"
})

-- /////////////////////////////////////////////////////////////////////////////////
-- ------------------------------------------------------------------------ RECIPES
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

-- Orichalcum Ingot
minetest.register_craft({
	type = "cooking",
	output = "orichalcum:orichalcum_ingot",
	recipe = "orichalcum:orichalcum_lump",
})

-- Orichalcum Axe Craft
minetest.register_craft({
    output = "orichalcum:orichalcum_tool_orichalcumaxe",
    recipe = {
        {"orichalcum:orichalcum_ingot", "orichalcum:orichalcum_ingot"},
        {"orichalcum:orichalcum_ingot","default:stick"},
        {"","default:stick"}
    }
})

-- Orichalcum Pickaxe Craft
minetest.register_craft({
    output = "orichalcum:orichalcum_tool_orichalcumpickaxe",
    recipe = {
        {"orichalcum:orichalcum_ingot","orichalcum:orichalcum_ingot","orichalcum:orichalcum_ingot"},
        {"", "default:stick", ""},
        {"", "default:stick", ""}
    }
})

-- Orichalcum Sword Craft
minetest.register_craft({
    output = "orichalcum:orichalcum_tool_orichalcumsword",
    recipe = {
        {"orichalcum:orichalcum_ingot"},
        {"orichalcum:orichalcum_ingot"},
        {"default:stick"}
    }
})

-- Orichalcum Shovel Craft
minetest.register_craft({
    output = "orichalcum:orichalcum_tool_orichalcumshovel",
    recipe = {
        {"orichalcum:orichalcum_ingot"},
        {"default:stick"},
        {"default:stick"}
    }
})

-- /////////////////////////////////////////////////////////////////////////////////
-- -------------------------------------------------------------------------- TOOLS
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

-- Orichalcum Axe Tool
minetest.register_tool("orichalcum:orichalcum_tool_orichalcumaxe", {
    description = "Orichalcum Axe",
    inventory_image = "orichalcum_tool_orichalcumaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.50, [2]=1.40, [3]=1.00}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {axe = 1}
})

-- Orichalcum Pickaxe Tool
minetest.register_tool("orichalcum:orichalcum_tool_orichalcumpickaxe", {
	description = "Orichalcum Pickaxe",
	inventory_image = "orichalcum_tool_orichalcumpickaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=4.00, [2]=1.60, [3]=0.80}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {pickaxe = 1}
})

-- Orichalcum Shovel Tool
minetest.register_tool("orichalcum:orichalcum_tool_orichalcumshovel", {
	description = "Orichalcum Shovel",
	inventory_image = "orichalcum_tool_orichalcumshovel.png",
	--wield_image = "default_tool_steelshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.50, [2]=0.90, [3]=0.40}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {shovel = 1}
})

-- Orichalcum Sword Tool
minetest.register_tool("orichalcum:orichalcum_tool_orichalcumsword", {
	description = "Orichalcum Sword",
	inventory_image = "orichalcum_tool_orichalcumsword.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=6},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {sword = 1}
})

-- /////////////////////////////////////////////////////////////////////////////////
-- ---------------------------------------------------------------------- WORLD GEN
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

minetest.register_ore({
    ore_type       = "scatter",
    ore            = "orichalcum:orichalcum_ore",
    wherein        = "default:stone",
    clust_scarcity = 9 * 9 * 9,
    clust_num_ores = 12,
    clust_size     = 3,
    y_max          = 31000,
    y_min          = 1025,
})

minetest.register_ore({
    ore_type       = "scatter",
    ore            = "orichalcum:orichalcum_ore",
    wherein        = "default:stone",
    clust_scarcity = 7 * 7 * 7,
    clust_num_ores = 5,
    clust_size     = 3,
    y_max          = 0,
    y_min          = -31000,
})

minetest.register_ore({
    ore_type       = "scatter",
    ore            = "orichalcum:orichalcum_ore",
    wherein        = "default:stone",
    clust_scarcity = 24 * 24 * 24,
    clust_num_ores = 27,
    clust_size     = 6,
    y_max          = -64,
    y_min          = -31000,
})