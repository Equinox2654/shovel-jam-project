extends Panel

@onready var item_visual: Sprite2D = $Item_display
@onready var highlight = $ColorRect
@onready var player = preload("res://Player.gd")

var current_item: InvItem

@onready var is_visible = highlight.visible

func update(item: InvItem):
	is_visible = highlight.visible
	if !item:
		item_visual.visible = false
	else:
		current_item = item
		item_visual.visible = true
		item_visual.texture = item.texture

func _ready() -> void:
	highlight.visible = false

func invis() -> void:
	highlight.visible = false
	player.current_item = ["Empty", "Empty"]

func visible() -> void:
	highlight.visible = true
	player.current_item[0] = current_item.get_item_name()
	player.current_item[1] = current_item.get_item_type()
