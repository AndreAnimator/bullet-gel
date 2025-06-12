class_name Bullet
extends CharacterBody2D

@export var hitbox = Area2D

@export var initial_speed = 100.0
@export var target_speed := 500.0
@export var acceleration = 1.0
@export var damage := 1.0
@export var is_parryable := true
var speed = initial_speed
var direction = Vector2.RIGHT
var duration = 2.0
var owner_location : Vector2
var reflected : bool = false

func _ready() -> void:
	direction = Vector2.RIGHT.rotated(global_rotation)
	owner_location = global_position
	if hitbox:
		hitbox.area_entered.connect(_on_hitbox_area_entered)

	await get_tree().create_timer(duration).timeout
	await _before_lifespan_expired()
	queue_free()

func _physics_process(delta: float) -> void:
	speed = lerp(speed, target_speed, acceleration * get_position_delta())
	velocity = direction * speed * delta
	var collision := move_and_collide(velocity)

	# if collision:
	#	print("era pra dar queue_free eu acho")
	#	queue_free()
		

func _on_hitbox_area_entered(area: Node2D):
	if area.is_in_group("solid"):
		queue_free()

func _before_lifespan_expired():
	pass
