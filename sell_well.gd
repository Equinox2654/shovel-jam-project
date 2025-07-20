extends Node2D

var player
var is_player = false
@export var carrot_item: InvItem
@export var lemon_item: InvItem
@export var hot_dog_item: InvItem
@onready var SFX = $AudioStreamPlayer

func _on_area_2d_body_entered(body: Node2D) -> void:
	player = body
	is_player = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	is_player = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("sell") and is_player:
		play()
		if player.toolbar.slots[2].item:
			if player.toolbar.slots[2].item.type == "Sellable":
				if player.toolbar.slots[2].item.name == "Carrot":
					player.sell(20, carrot_item)
				elif player.toolbar.slots[2].item.name == "Lemon":
					player.sell(40, lemon_item)
				elif player.toolbar.slots[2].item.name == "Hot Dog":
					player.sell(1500, hot_dog_item)

func play() -> void:
	if SFX.playing:
		await SFX.finished
	SFX.play()
