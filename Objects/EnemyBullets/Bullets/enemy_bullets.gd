extends Bullet

func _on_hitbox_area_entered(area: Node2D):
	if area.is_in_group("player") and !reflected:
		if is_parryable:
			var area_parent = area.get_parent()
			if area_parent.dashing and area_parent.can_parry:
				reflected = true
				print("Ele consegue dar parry?")
				print("Rotação inicial")
				print(rotation)
				add_to_group("player_bullet")
				remove_from_group("enemy_bullet")
				hitbox.change_mask_value(4, false)
				hitbox.change_layer_value(7, false)
				hitbox.change_layer_value(4, true)
				hitbox.change_mask_value(7, true)
				var owner_rotation = owner_location - area_parent.global_position
				direction = owner_rotation
				# global_rotation += 3.14
				# acceleration *= 1.05
				print("deu parry")
				print("Rotação final")
				print(rotation)
			elif !area_parent.is_invincible():
				var attack := Attack.new()
				print("Encostou no player")
				area.damage(attack)
				queue_free()
	if area.is_in_group("enemy") and reflected:
		print("Tomou a refletida")
		var attack := Attack.new()
		area.damage(attack)
		queue_free()
		#TODO adaptar isso pra usar hurtbox no lugar
		# if !area.is_invincible():
		# 	area.take_damage(damage)
