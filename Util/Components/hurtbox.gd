class_name HurtBox
extends Area2D

# signal hit_enemy #fazer genérico pro player

@onready var bullet : Bullets = get_owner()

func _ready() -> void:
	area_entered.connect(on_area_entered)

func on_area_entered(area: Area2D):
	pass
	# if area is HitBox:
	# 	var attack = Attack.new()
	#	attack.damage = bullet.damage
	#	area.damage(attack)
		# hit_enemy.emit() # TODO fazer genérico pro player
