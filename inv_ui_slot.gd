extends Panel

@onready var item_visual: Sprite2D = $Item_display
@onready var highlight = $ColorRect
@onready var player = preload("res://Player.gd")
@onready var label = $Label

signal button_pressed

var current_item: InvItem
var current_amount: int

@onready var is_visible = highlight.visible

func update(slot: InvSlot):
	is_visible = highlight.visible
	if !slot.item:
		item_visual.visible = false
		label.visible = false
	else:
		if slot.amount != 0:
			current_item = slot.item
			current_amount = slot.amount
			item_visual.visible = true
			label.visible = false
			item_visual.texture = slot.item.texture
			if slot.amount > 1:
				label.visible = true
				label.text = str(slot.amount)
		else:
			slot.item = null

func _ready() -> void:
	highlight.visible = false

func invis() -> void:
	highlight.visible = false

func visible() -> void:
	highlight.visible = true

func is_selected() -> bool:
	if highlight.visible:
		return true
	return false


func _on_button_pressed() -> void:
	button_pressed.emit()


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass
