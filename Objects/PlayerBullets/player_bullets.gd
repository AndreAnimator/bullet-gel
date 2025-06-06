extends Bullet

func _on_hitbox_area_entered(area: Node2D):
	if area.is_in_group("enemy"):
		print("Encostou no inimigo")
		var attack := Attack.new()
		area.damage(attack)
		#TODO adaptar isso pra usar hurtbox no lugar
		# if !area.is_invincible():
		# 	area.take_damage(damage)
