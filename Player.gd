extends character

@export var inv: Inv
@export var toolbar: ToolBar
@onready var Player_Inv = preload("res://Inventory/PlayerInv.tres")
@onready var Player_toolbar = preload("res://Inventory/Toolbar/PlayerToolBar.tres")
@onready var store_ui = $ShopKeeperStore
var is_interactable: bool = false
var money: int = 100

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
var current_item: = {
	"name": "Empty",
	"type": "Empty"
}

var empty_hand: = {
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

func _process(delta: float) -> void:
	update($PlayerSprite)
	set_current_item()
	interact()
	$Prices/Label.text = str(money)
	if toolbar.slots[2].item != null:
		player_toolbar[2] = {
			"name": toolbar.slots[2].item.name,
			"type": toolbar.slots[2].item.type
		}

func _physics_process(delta: float) -> void:
	physics_update(delta)

func set_current_item() -> void:
	if Input.is_action_just_pressed("1") and current_item != player_toolbar[0]:
		current_item = player_toolbar[0]
	elif Input.is_action_just_pressed("1") and current_item == player_toolbar[0]:
		current_item = empty_hand
	if Input.is_action_just_pressed("2") and current_item != player_toolbar[1]:
		current_item = player_toolbar[1]
	elif Input.is_action_just_pressed("2") and current_item == player_toolbar[1]:
		current_item = empty_hand
	if Input.is_action_just_pressed("3") and current_item != player_toolbar[2]:
		current_item = player_toolbar[2]
	elif Input.is_action_just_pressed("3") and current_item == player_toolbar[2]:
		current_item = empty_hand

func collect(item: InvItem):
	inv.insert(item)

func interact():
	if is_interactable and Input.is_action_just_pressed("Interact") and !store_ui.visible:
		store_ui.open()
	else:
		if Input.is_action_just_pressed("Interact"):
			store_ui.close()

func buy(price: int, item: InvItem):
	if money - price >= 0:
		money -= price
		collect(item)

func _on_area_2d_area_entered(area: Area2D) -> void:
	is_interactable = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	is_interactable = false
