class_name Bullet
extends CharacterBody2D

@export var hurtbox : HurtBox

@export var speed := 20.0
@export var damage := 1.0
var duration = 4000

func _ready() -> void:
	if hurtbox:
		hurtbox.hit_enemy.connect(on_enemy_hit)

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)

	velocity = direction * speed
	var collision := move_and_collide(velocity*delta)
	
	duration -= 1

	if collision:
		queue_free()
	elif duration == 0:
		queue_free()

func on_enemy_hit():
	queue_free()
