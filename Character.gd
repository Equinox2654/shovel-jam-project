extends CharacterBody2D

class_name character

var movespeed: int
var direction_facing: String
var is_sprint: bool

func create(movespeed: int, direction_facing: String) -> void:
	self.movespeed = movespeed
	self.direction_facing = direction_facing
	self.is_sprint = false
	
func face_direction() -> void:
	var x_axis_direction = velocity.x
	var y_axis_direction = velocity.y
	if y_axis_direction <= -1:
		self.direction_facing = "up"
	elif y_axis_direction >= 1:
		self.direction_facing = "down"
	if x_axis_direction <= -1:
		self.direction_facing = "left"
	elif x_axis_direction >= 1:
		self.direction_facing = "right"

func anim_direction(sprite: AnimatedSprite2D) -> void:
	if velocity.y == 0:
		if self.direction_facing == "up":
			sprite.play("Idle_up")
			sprite.set_flip_h(0)
		if self.direction_facing == "down":
			sprite.play("Idle_down")
			sprite.set_flip_h(0)
	if velocity.x == 0:
		if self.direction_facing == "left":
			sprite.play("Idle_side")
			sprite.set_flip_h(1)
		if self.direction_facing == "right":
			sprite.play("Idle_side")
			sprite.set_flip_h(0)

func move(delta: float) -> void:
	#Child finishes function
	pass
	
func anim_move(sprite: AnimatedSprite2D) -> void:
	if self.is_sprint:
		if velocity.y != 0:
			if self.direction_facing == "up":
				sprite.play("Sprint_up")
				sprite.set_flip_h(0)
			if self.direction_facing == "down":
				sprite.play("Sprint_down")
		if velocity.x != 0:
			if self.direction_facing == "left":
				sprite.play("Sprint_side")
				sprite.set_flip_h(1)
			if self.direction_facing == "right":
				sprite.play("Sprint_side")
				sprite.set_flip_h(0)
	else:
		if velocity.y != 0:
			if self.direction_facing == "up":
				sprite.play("Walk_up")
				sprite.set_flip_h(0)
			if self.direction_facing == "down":
				sprite.play("Walk_down")
		if velocity.x != 0:
			if self.direction_facing == "left":
				sprite.play("Walk_side")
				sprite.set_flip_h(1)
			if self.direction_facing == "right":
				sprite.play("Walk_side")
				sprite.set_flip_h(0)

func update(sprite: AnimatedSprite2D) -> void:
	face_direction()
	anim_direction(sprite)
	anim_move(sprite)


func physics_update(delta: float) -> void:
	move(delta)
