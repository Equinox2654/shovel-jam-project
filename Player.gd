extends character

func _init() -> void:
	create(16, "right")

func move(delta: float) -> void:
	velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * movespeed
	move_and_slide()

func _process(delta: float) -> void:
	update($PlayerSprite)

func _physics_process(delta: float) -> void:
	physics_update(delta)
