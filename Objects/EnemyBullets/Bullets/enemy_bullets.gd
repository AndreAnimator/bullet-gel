extends Bullet

func _on_hitbox_area_entered(area: Node2D):
	print("Entrou quantas vezes")
	if area.is_in_group("player") and !reflected:
		if is_parryable:
			var area_parent = area.get_parent()
			if area_parent.dashing and area_parent.can_parry:
				reflected = true
				print("Ele consegue dar parry?")
				print("Rotação inicial")
				print(direction)
				add_to_group("player_bullet")
				remove_from_group("enemy_bullet")
				hitbox.change_mask_value(4, false)
				hitbox.change_layer_value(7, false)
				hitbox.change_layer_value(4, true)
				hitbox.change_mask_value(7, true)
				target_speed = 100
				# var shooter = get_parent()
				# shooter.change_layer_value(2, true)
				var owner_rotation = owner_location - area_parent.position
				direction = (owner_rotation/speed) * 3.0
				# global_rotation += 3.14
				# acceleration *= 1.05
				print("deu parry")
				print("Rotação final")
				print(direction)
				print("NÃO É PRA DESTRUIR A BALA")
			elif !area_parent.is_invincible():
				var attack := Attack.new()
				print("Encostou no player")
				area.damage(attack)
				queue_free()
	if area.is_in_group("enemy") and reflected:
		print("Tomou a refletida")
		var attack := Attack.new()
		var area_parent = area.get_parent()
		if area_parent.is_in_group("shielded_enemy"):
			area.shield_damage(attack)
		else:
			area.damage(attack)
			area.stun(attack)
		queue_free()
		#TODO adaptar isso pra usar hurtbox no lugar
		# if !area.is_invincible():
		# 	area.take_damage(damage)
