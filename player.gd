extends CharacterBody2D

var speed: float = 200
var acceleration: float = 2000
var friction: float = acceleration / speed
var hp = 3 : set = set_hp, get = get_hp
const check_point: Vector2 = Vector2(0, 0)
var can_move: bool = true
var invincible: bool = false

# dash controls

const dash_speed = 90.0
var dashing = false
var can_dash = true

signal hp_changed
signal died

func _process(delta: float) -> void:
	apply_traction(delta) 
	apply_friction(delta)

func _physics_process(delta: float) -> void:
	move_and_slide()

func apply_traction(delta: float) -> void:
	var traction: Vector2 = Vector2()

	if(can_move):
		if Input.is_action_pressed("ui_up"):
			traction.y -= 1
		if Input.is_action_pressed("ui_down"):
			traction.y += 1
		if Input.is_action_pressed("ui_left"):
			traction.x -= 1
		if Input.is_action_pressed("ui_right"):
			traction.x += 1
	
	traction = traction.normalized()
	if Input.is_action_pressed("dash") and can_dash:
		can_dash = false
		dashing = true
		can_move = false
		invincible = true
		$DashTimer.start()
		$DashAgainTimer.start()


	if dashing:
		velocity += traction * dash_speed * acceleration * delta
	else:
		velocity += traction * acceleration * delta

func apply_friction(delta: float) -> void:
	velocity -= velocity * friction * delta

func take_damage(dmg):
	if(!invincible):
		set_hp(hp - dmg)

func get_hp():
	return hp

func set_hp(new_hp):
	emit_signal("hp_changed", new_hp)
	hp = new_hp
	if hp <= 0:
		die()

func is_invincible():
	return invincible

func die():
	get_tree().call_group("respawn", respawn())  
	set_hp(3)

func respawn():
	emit_signal("died")
	position = check_point


func _on_dash_timer_timeout() -> void:
	dashing = false
	can_move = true
	invincible = false


func _on_dash_again_timer_timeout() -> void:
	can_dash = true
