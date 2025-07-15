extends Control

var is_open: bool = false
@onready var inv: Inv = preload("res://Inventory/PlayerInv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

func _ready():
	update_slots()
	close()

func update_slots():
	for i in range(min(inv.items.size(), slots.size())):
		slots[i].update(inv.items[i])

func open():
	self.visible = true
	is_open = true

func close():
	self.visible = false
	is_open = false

func _process(delta) -> void:
	if Input.is_action_just_pressed("Inventory"):
		if is_open:
			close()
		else:
			open()
