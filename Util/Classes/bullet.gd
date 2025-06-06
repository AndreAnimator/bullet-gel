class_name Bullet
extends CharacterBody2D

@export var hitbox = Area2D

@export var initial_speed = 1000.0
@export var target_speed := 980.0
@export var acceleraton = 2.0
@export var damage := 1.0
var speed = initial_speed
var direction = Vector2.RIGHT
var duration = 1.0

func _ready() -> void:
	direction = Vector2.RIGHT.rotated(global_rotation)
	if hitbox:
		hitbox.area_entered.connect(_on_hitbox_area_entered)

	await get_tree().create_timer(duration).timeout
	await _before_lifespan_expired()
	queue_free()

func _physics_process(delta: float) -> void:
	speed = lerp(speed, target_speed, acceleraton * get_position_delta())
	velocity = direction * speed * delta
	var collision := move_and_collide(velocity)

	if collision:
		queue_free()
		

func _on_hitbox_area_entered(area: Node2D):
	pass

func _before_lifespan_expired():
	pass
