extends CharacterBody2D
class_name Bullets

@export var hurtbox : HurtBox

@export var speed := 150.0
@export var damage := 1.0

var duration = 4000

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += speed * direction
	# var collision := move_and_collide(velocity*delta)

	var collision := move_and_collide(position*delta)
	duration -= 1
	if duration == 0:
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("player"):
		if !body.is_invincible():
			body.take_damage(1)
			queue_free()
	if body.is_in_group("solid"):
		queue_free()

func _on_bullet_hurtbox_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
