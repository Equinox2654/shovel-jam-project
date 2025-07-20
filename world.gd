extends Node2D

@onready var tile_map: TileMap = $TileMap
@onready var player = $Player
@export var carrot_item: InvItem

var soil_layer = 0
var seed_layer = 1
var soil: Vector2i = Vector2i(7, 8)
var dry_tilled_soil: Vector2i = Vector2i(3, 9)
var wet_tilled_soil: Vector2i = Vector2i(0, 9)
var tile_mouse_pos
var can_place_seed_custom_data = "can_place_seeds"
var can_collect_item = "can_collect"
var seed = "seed"
var tile_map_position: Vector2i
var amount_time: float

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Use"):
		tile_mouse_pos = get_global_mouse_position()
		tile_map_position = tile_map.local_to_map(tile_mouse_pos)
		var tile_id = tile_map.get_cell_atlas_coords(soil_layer, tile_map_position)
		var seed_id = tile_map.get_cell_atlas_coords(seed_layer, tile_map_position)
		var tile_data: TileData = tile_map.get_cell_tile_data(soil_layer, tile_map_position)
		var seed_data: TileData = tile_map.get_cell_tile_data(seed_layer, tile_map_position)
		var atlas_coord
		
		if tile_data:
			var can_place_seeds = tile_data.get_custom_data(can_place_seed_custom_data)
			if seed_data:
				var can_collect = seed_data.get_custom_data(can_collect_item)
				if can_collect:
					harvest_plant(tile_map_position, 0, seed_id)
			var final_seed_level
			if can_place_seeds:
				if player.toolbar.slots[2].item:
					if player.current_item["type"] == "Seed":
						if player.current_item["name"] == "Carrot":
							final_seed_level = 1
							atlas_coord = Vector2i(0, 15)
							amount_time = 10.0
						else:
							final_seed_level = null
							atlas_coord = null
						if final_seed_level and atlas_coord:
							handle_seed(tile_map_position, 0, atlas_coord, final_seed_level, amount_time)
		if tile_id == soil:
			if player.current_item["name"] == "Hoe":
				tile_map.set_cell(soil_layer, tile_map_position, 0, dry_tilled_soil)
		if tile_id == dry_tilled_soil:
			if player.current_item["name"] == "Watering Can":
				tile_map.set_cell(soil_layer, tile_map_position, 0, wet_tilled_soil)

func harvest_plant(tile_pos: Vector2i, source_id, tile_id) -> void:
	if tile_id == Vector2i(1, 15):
		player.collect(carrot_item)
		tile_map.set_cell(seed_layer, tile_map_position, 0, Vector2i(0, 14))

func handle_seed(tile_map_pos, level, atlas_coord, final_seed_level, amt_time, already_set = false):
	var seed_data: TileData = tile_map.get_cell_tile_data(seed_layer, tile_map_position)
	var is_seed = false
	if seed_data:
		is_seed = seed_data.get_custom_data(seed)
	if !is_seed:
		var source_id: int = 0
		if !already_set:
			tile_map.set_cell(seed_layer, tile_map_pos, source_id, atlas_coord)
			if player.toolbar.slots[2].amount == 1:
				player.toolbar.slots[2].item = null
			player.toolbar.slots[2].amount -= 1
		
		if level != final_seed_level:
			await get_tree().create_timer(amt_time).timeout
			var new_atlas: Vector2i = Vector2i(atlas_coord.x + 1, atlas_coord.y)
			tile_map.set_cell(seed_layer, tile_map_pos, source_id, new_atlas)
			handle_seed(tile_map_pos, level + 1, new_atlas, final_seed_level, amt_time, true)
		else:
			return
