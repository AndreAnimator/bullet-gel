class_name Player
extends CharacterBody2D

@export var hitbox : HitBox
@export var sprite : Sprite2D
var speed: float = 200
var acceleration: float = 2000
var friction: float = acceleration / speed
var hp = 3 : set = set_hp, get = get_hp
const check_point: Vector2 = Vector2(0, 0)
var can_move: bool = true
var invincible: bool = false
var can_shoot: bool = true
var attack := Attack.new()
var can_parry: bool = true
var damaged_duration: float = 0.15

# dash controls

const dash_speed = 90.0
var dashing = false
var can_dash = true

# camera variable

var aim_position : Vector2 = Vector2(1, 0)

signal hp_changed
signal died
signal player_shoot

func _ready():
	sprite.material.set_shader_parameter("flash_modifier", 0)
	if hitbox:
		hitbox.damaged.connect(take_damage)

# Camera Movement Control

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var half_viewport = get_viewport_rect().size / 2.0
		aim_position = (event.position - half_viewport)

func _process(delta: float) -> void:
	apply_traction(delta) 
	apply_friction(delta)

func _physics_process(delta: float) -> void:
	move_and_slide()
	if can_move and can_shoot:
		if Input.is_action_just_pressed("primary_fire"):
			emit_signal("player_shoot")

func apply_traction(delta: float) -> void:
	var traction: Vector2 = Vector2()

	if(can_move):
		if Input.is_action_pressed("move_up"):
			traction.y -= 1
		if Input.is_action_pressed("move_down"):
			traction.y += 1
		if Input.is_action_pressed("move_left"):
			traction.x -= 1
		if Input.is_action_pressed("move_right"):
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

func take_damage(damage: Attack):
	if(!invincible):
		set_hp(hp - damage.damage)

func get_hp():
	return hp

func set_hp(new_hp):
	emit_signal("hp_changed", new_hp)
	hp = new_hp
	if hp <= 0:
		die()
	sprite.material.set_shader_parameter("flash_modifier", 1)
	invincible = true
	await get_tree().create_timer(damaged_duration).timeout
	invincible = false
	sprite.material.set_shader_parameter("flash_modifier", 0)

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


func _on_hit_box_body_entered(body:Node2D) -> void:
	print("Isso sequer entra?")
	if body.is_in_group("enemy"):
		#TODO adaptar isso pra usar hurtbox no lugar
		if !body.is_invincible():
			take_damage(attack)
	if body.is_in_group("enemy_bullet"):
		print("Tomou do enemigo")
		take_damage(body.initial_damage)
