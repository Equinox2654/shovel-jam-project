extends Node2D

@onready var tile_map: TileMap = $TileMap
@onready var player = $Player

var soil_layer = 0

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Use"):
		var mouse_pos: Vector2 = get_global_mouse_position()
		var tile_map_position: Vector2i = tile_map.local_to_map(mouse_pos)
		var tile_id = tile_map.get_cell_atlas_coords(soil_layer, tile_map_position)
		if tile_id == Vector2i(4, 5):
			if player.current_item["name"] == "Hoe":
				tile_map.set_cell(soil_layer, tile_map_position, 0, Vector2i(1, 5))
		if tile_id == Vector2i(1, 5):
			if player.current_item["name"] == "Watering Can":
				tile_map.set_cell(soil_layer, tile_map_position, 0, Vector2i(0, 5))
