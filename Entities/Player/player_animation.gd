extends Node

@export var animation_tree : AnimationTree
@export var sprite : Sprite2D

@onready var player : Player = get_owner()

func _ready():
	animation_tree.active = true
	print("Ativou árvore")

func _physics_process(delta: float) -> void:
	var velocity = player.velocity
	print("pega a velocidade do player")

	if velocity.x > 1.0 or velocity.x < -1.0 or velocity.y > 1.0 or velocity.y < -1.0:
		var time_scale = 1

		if sign(player.aim_position.x) != sign(player.velocity.x):
			time_scale = -1
		
		animation_tree.set("parameters/TimeScale/scale", time_scale)
		animation_tree.set("parameters/WalkDirection/blend_position", sign(player.aim_position.x))
	else:
		sprite.flip_h = player.aim_position.x < 0
		animation_tree.set("parameters/TimeScale/scale", 1)
		animation_tree.set("parameters/WalkDirection/blend_position", 0)
