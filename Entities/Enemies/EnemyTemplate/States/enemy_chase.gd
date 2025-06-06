extends EnemyState

@export var chase_speed := 75.0

var shooting_frequency = 80
var shooting_wait = 0

const obj_bullet = preload("res://Objects/EnemyBullets/Bullets/bullets.tscn")

func physics_process_state(delta: float):
	var direction = player.global_position - enemy.global_position

	var distance = direction.length()
	if distance > enemy.chase_radius:
		transitioned.emit(self, "wander")
		return
	
	enemy.velocity = direction.normalized()*chase_speed

	if distance <= enemy.follow_radius:
		enemy.velocity = Vector2.ZERO
	
	enemy.move_and_slide()

	shooting_wait += 1
	if shooting_wait == shooting_frequency:
		shoot()
		shooting_wait = 0

func shoot():
	print("Atira caralho")
	var spawned_bullet := obj_bullet.instantiate()
	var player_direction = player.global_position - enemy.global_position
	spawned_bullet.position = enemy.global_position
	get_tree().root.call_deferred("add_child", spawned_bullet)
	spawned_bullet.rotation = player_direction.angle()
