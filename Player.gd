extends character

@export var inv: Inv
@onready var Player_Inv = preload("res://Inventory/PlayerInv.tres")
var current_item: Array[String]

func _init() -> void:
	create(16, "right")

func move(delta: float) -> void:
	velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * movespeed
	if Input.is_action_pressed("Sprint"):
		velocity *= 2
	move_and_slide()

func pickup_item(item: InvItem) -> void:
	pass

func _process(delta: float) -> void:
	update($PlayerSprite)

func _physics_process(delta: float) -> void:
	physics_update(delta)
