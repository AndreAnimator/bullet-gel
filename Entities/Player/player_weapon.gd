extends Node2D

@export var firing_position : Marker2D

@onready var player : Player = get_owner()
var firing_speed : float = 150

const obj_bullet = preload("res://Objects/PlayerBullets/player_bullets.tscn")

func _on_character_body_2d_player_shoot():
	if sign(player.aim_position.x) != sign(firing_position.position.x):
		firing_position.position.x *= -1
	
	var spawned_bullet := obj_bullet.instantiate()
	var mouse_direction := get_global_mouse_position()
	spawned_bullet.velocity = Vector2(firing_speed, 0).rotated(mouse_direction.angle())
	spawned_bullet.global_position = firing_position.global_position
	spawned_bullet.rotation = mouse_direction.angle()
	get_parent().add_child(spawned_bullet)
