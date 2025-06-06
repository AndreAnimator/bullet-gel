class_name Enemy
extends CharacterBody2D
#tem que fazer ele extender a mesma classe que o player

const check_point: Vector2 = Vector2(169.0, -39.0)

var invincible = false # stunned
var isAlive := true
var health: int = 3

signal damaged(attack: Attack)

@export var hitbox : HitBox
@export_group("Vision Ranges")
@export var detection_radius := 100.0
@export var chase_radius := 200.0
@export var follow_radius := 25.0

func _ready():
	if hitbox:
		hitbox.damaged.connect(take_damage)

func respawn():
	print("ele respawna?")
	position = check_point
	isAlive = true
	health = 3


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Isso sequer entra?")
	if body.is_in_group("player"):
		print("Encostou no jogador")
		#TODO adaptar isso pra usar hurtbox no lugar
		if !body.is_invincible():
			body.take_damage(1)
	if body.is_in_group("player_bullet"):
		print("Enimigo tomou")
		take_damage(body.initial_damage)

func take_damage(attack:Attack):
	print("Tomou lhe")
	if(!invincible):
		health -= attack.damage
		if health <= 0:
			print("Esse bixo não morre não??")
			queue_free()

func is_invincible():
	return invincible

func _on_hitbox_damaged(attack:Attack) -> void:
	print("jumpscare q isso funciona")
	take_damage(attack)
	damaged.emit(attack)
