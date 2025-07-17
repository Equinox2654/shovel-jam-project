extends Control

var is_open: bool = false
@onready var inv: Inv = preload("res://Inventory/PlayerInv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
var player

func _ready():
	inv.update.connect(update_slots)
	update_slots()
	close()
	z_index = 1

func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])

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


func _on_inv_ui_slot_1_button_pressed() -> void:
	on_button_pressed(slots[0])


func _on_inv_ui_slot_2_button_pressed() -> void:
	on_button_pressed(slots[1])


func _on_inv_ui_slot_3_button_pressed() -> void:
	on_button_pressed(slots[2])


func _on_inv_ui_slot_4_button_pressed() -> void:
	on_button_pressed(slots[3])


func _on_inv_ui_slot_5_button_pressed() -> void:
	on_button_pressed(slots[4])


func _on_inv_ui_slot_6_button_pressed() -> void:
	on_button_pressed(slots[5])


func _on_inv_ui_slot_7_button_pressed() -> void:
	on_button_pressed(slots[6])


func _on_inv_ui_slot_8_button_pressed() -> void:
	on_button_pressed(slots[7])


func _on_inv_ui_slot_9_button_pressed() -> void:
	on_button_pressed(slots[8])


func _on_inv_ui_slot_10_button_pressed() -> void:
	on_button_pressed(slots[9])


func _on_inv_ui_slot_11_button_pressed() -> void:
	on_button_pressed(slots[10])


func _on_inv_ui_slot_12_button_pressed() -> void:
	on_button_pressed(slots[11])

func on_button_pressed(slot: InvSlot) -> void:
	if slot.amount == 0:
		pass
	elif slot.amount == 1:
		if player.toolbar[2].item == slot.item:
			player.toolbar[2].amount += 1
		if player.toolbar[2].item == null:
			player.toolbar.insert(slot.item)
			slot.amount = 1
		slot.item = null
		slot.amount = 0
	else:
		slot.amount -= 1
		if player.toolbar[2].item != null and player.toolbar[2].item == slot.item:
			player.toolbar[2].amount += 1
		elif player.toolbar[2].item != slot.item:
			pass
		elif player.toolbar[2].item == null:
			player.toolbar.insert(slot.item)
			player.toolbar[2].amount = 1

func _on_area_2d_body_entered(body: Node2D) -> void:
	player = body
