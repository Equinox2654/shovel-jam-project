extends Control

@onready var tool: ToolBar = preload("res://Inventory/Toolbar/PlayerToolBar.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

func _ready() -> void:
	z_index = 10

func update_slots():
	for i in range(min(tool.slots.size(), slots.size())):
		slots[i].update(tool.slots[i])
		if Input.is_action_just_pressed("1") and i == 0:
			if !slots[i].is_visible:
				slots[1].invis()
				slots[2].invis()
				slots[i].visible()
			else:
				slots[i].invis()
		elif Input.is_action_just_pressed("2") and i == 1:
			if slots[i].is_visible:
				slots[i].invis()
			else:
				slots[0].invis()
				slots[2].invis()
				slots[i].visible()
		elif Input.is_action_just_pressed("3") and i == 2:
			if slots[i].is_visible:
				slots[i].invis()
			else:
				slots[0].invis()
				slots[1].invis()
				slots[i].visible()

func _process(delta: float) -> void:
	update_slots()
