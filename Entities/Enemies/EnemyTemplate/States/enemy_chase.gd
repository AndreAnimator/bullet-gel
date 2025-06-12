extends EnemyState

@export var chase_speed := 75.0

var shooting_frequency = 80
var shooting_wait = 0
var shooting_quantity = 0
var maximum_shooting = 5
var shooting_pause := false
var pause_wait_duration = 2.0
var pause_finished_duration = 0.25
var teste := false

const obj_bullet = preload("res://Objects/EnemyBullets/Bullets/bullets.tscn")

func physics_process_state(delta: float):
	var direction = player.global_position - enemy.global_position

	var distance = direction.length()
	if distance > enemy.chase_radius:
		transitioned.emit(self, "wander")
		return
	
	if teste:
		enemy.velocity = direction.normalized()*chase_speed

		if distance <= enemy.follow_radius:
			enemy.velocity = Vector2.ZERO
		
		enemy.move_and_slide()
	shooting_wait += 1
	if shooting_quantity == maximum_shooting and shooting_wait == shooting_frequency:
		shooting_quantity = 0
		shooting_pause = true
		await get_tree().create_timer(pause_wait_duration).timeout
		shoot()
		shooting_wait = 0
		await get_tree().create_timer(pause_finished_duration).timeout
		shooting_pause = false
	if shooting_wait == shooting_frequency:
		shoot()
		shooting_wait = 0
		shooting_quantity += 1

func shoot():
	var spawned_bullet := obj_bullet.instantiate()
	var player_direction = player.global_position - enemy.global_position
	spawned_bullet.position = enemy.global_position
	await get_tree().create_timer(pause_finished_duration).timeout
	get_tree().root.call_deferred("add_child", spawned_bullet)
	spawned_bullet.rotation = player_direction.angle()
