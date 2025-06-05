class_name Enemy
extends CharacterBody2D
#tem que fazer ele extender a mesma classe que o player

const check_point: Vector2 = Vector2(169.0, -39.0)

var invincible = false # stunned
var isAlive := true
var health: int = 3

signal damaged(attack: Attack)

@export_group("Vision Ranges")
@export var detection_radius := 100.0
@export var chase_radius := 200.0
@export var follow_radius := 25.0

func respawn():
	print("ele respawna?")
	position = check_point
	isAlive = true
	health = 3


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		#TODO adaptar isso pra usar hurtbox no lugar
		if body.is_invincible():
			body.take_damage(1)

func take_damage(dmg):
	print("Tomou lhe")
	if(!invincible):
		health -= dmg
		if health <= 0:
			queue_free()

func is_invincible():
	return invincible

func _on_hitbox_damaged(attack:Attack) -> void:
	print("jumpscare q isso funciona")
	damaged.emit(attack)