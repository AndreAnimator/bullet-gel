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

	if velocity:
		var time_scale = 1
		print("Ta velocity")

		if sign(player.aim_position.x) != sign(player.velocity.x):
			time_scale = -1
			print("Inverte posição")
		
		animation_tree.set("parameters/TimeScale/scale", time_scale)
		animation_tree.set("parameters/WalkDirection/blend_position", sign(player.aim_position.x))
		print("Seta as animation tree")
	else:
		sprite.flip_h = player.aim_position.x < 0
		animation_tree.set("parameters/TimeScale/scale", 1)
		animation_tree.set("parametes/WalkDirection/blend_position", 0)
		print("Seta as animation tree")
