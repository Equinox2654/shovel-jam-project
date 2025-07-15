extends Resource

class_name InvItem

@export var name: String = " "
@export var texture: Texture2D
@export var type: String = " "

func get_item_name() -> String:
	return self.name

func get_item_type() -> String:
	return self.type
