extends CharacterBody2D

const obj_bullet = preload("res://bullets.tscn")
const check_point: Vector2 = Vector2(169.0, -39.0)
var shooting_frequency = 80
var shooting_wait = 0
var can_move = true
var movement_speed: float = 50
var acceleration: float = 500
var friction: float = acceleration / movement_speed
var facing: int = 0

func _process(delta: float) -> void:
	shooting_wait += 1
	if shooting_wait == shooting_frequency:
		shoot(180, 50)
		shooting_wait = 0
	movement(delta)

func _physics_process(delta: float) -> void:
	move_and_slide()

func movement(delta: float):
	apply_traction(delta)
	apply_friction(delta)

func apply_traction(delta: float) -> void:
	var traction: Vector2 = Vector2()

	if(can_move):
		if facing == 0:
			traction.y -= 1
		if facing == 1:
			traction.y += 1
		if facing == 2:
			traction.x -= 1
		if facing == 3:
			traction.x += 1
	
	traction = traction.normalized()

	velocity += traction * acceleration * delta

func apply_friction(delta: float) -> void:
	velocity -= velocity * friction * delta

func shoot(direction: float, speed):
	var new_bullet = obj_bullet.instantiate()
	new_bullet.velocity = Vector2(speed, 0).rotated(deg_to_rad(direction))
	new_bullet.position = position
	get_parent().add_child(new_bullet)

func respawn():
	position = check_point


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.is_invincible():
			body.take_damage(1)
	if body.is_in_group("solid"):
		if facing == 1:
			facing = 0
		else:
			facing = 1
