extends Node2D

@export var firing_position : Marker2D

@onready var player : Player = get_owner()

const obj_bullet = preload("res://Objects/PlayerBullets/player_bullets.tscn")

func _on_character_body_2d_player_shoot():
	var spawned_bullet := obj_bullet.instantiate()
	var mouse_direction := get_global_mouse_position() - firing_position.global_position
	spawned_bullet.position = global_position
	get_tree().root.call_deferred("add_child", spawned_bullet)
	spawned_bullet.rotation = mouse_direction.angle()
	# spawned_bullet.velocity = Vector2(firing_speed, 0).rotated(mouse_direction.angle())
	# spawned_bullet.rotation = mouse_direction.angle()
