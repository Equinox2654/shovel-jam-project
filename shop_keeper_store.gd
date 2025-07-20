extends Control

var buy: bool = false
var item: InvItem
var price: int
@export var item1: InvItem
@export var item2: InvItem
@export var item3: InvItem
@onready var player = null

func open():
	self.visible = true

func close():
	self.visible = false

func _ready() -> void:
	self.visible = false
	z_index = 10

func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	player = body


func _on_carrot_button_pressed() -> void:
	player.buy(10, item1)


func _on_lemon_button_pressed() -> void:
	player.buy(25, item2)


func _on_hot_dog_button_pressed() -> void:
	player.buy(1000, item3)
