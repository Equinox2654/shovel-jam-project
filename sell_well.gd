extends Node2D

var player
var is_player = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	player = body
	is_player = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	is_player = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("sell") and is_player:
		pass
