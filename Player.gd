extends character

@export var inv: Inv
@export var toolbar: ToolBar
@onready var Player_Inv = preload("res://Inventory/PlayerInv.tres")
@onready var Player_toolbar = preload("res://Inventory/Toolbar/PlayerToolBar.tres")
var player_inv = []
var player_toolbar = [
	{
		"name": "Hoe",
		"type": "default"
	},
	{
		"name": "Watering Can",
		"type": "default"
	},
	{
		"name": "Empty",
		"type": "Empty"
	}
]
var current_item = {
	"name": "Empty",
	"type": "Empty"
}

func _init() -> void:
	create(32, "right")
	self.z_index = 8

func move(delta: float) -> void:
	velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * movespeed
	self.is_sprint = false
	if Input.is_action_pressed("Sprint"):
		velocity *= 2
		self.is_sprint = true
	move_and_slide()

func pickup_item(item: InvItem) -> void:
	pass

func _process(delta: float) -> void:
	update($PlayerSprite)
	set_current_item()

func _physics_process(delta: float) -> void:
	physics_update(delta)

func set_current_item() -> void:
	if Input.is_action_just_pressed("1") and current_item == player_toolbar[0]:
		current_item = "Empty"
	if Input.is_action_just_pressed("2") and current_item == player_toolbar[1]:
		current_item = "Empty"
	if Input.is_action_just_pressed("3") and current_item == player_toolbar[2]:
		current_item = "Empty"
	if Input.is_action_just_pressed("1"):
		current_item = player_toolbar[0]
	if Input.is_action_just_pressed("2"):
		current_item = player_toolbar[1]
	if Input.is_action_just_pressed("3"):
		current_item = player_toolbar[2]
