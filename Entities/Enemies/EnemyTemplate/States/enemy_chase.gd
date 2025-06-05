extends EnemyState

@export var chase_speed := 75.0

var shooting_frequency = 80
var shooting_wait = 0

const obj_bullet = preload("res://Objects/Bullets/bullets.tscn")

func physics_process_state(delta: float):
	print("persiga")
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
		print(" o que é direção ")
		print("pou pou")
		print(direction)
		shoot(direction, 20)
		shooting_wait = 0

func shoot(direction: Vector2, speed):
	print("Atira caralho")
	var player = get_tree().get_first_node_in_group("player")
	var new_bullet = obj_bullet.instantiate()
	direction = direction - enemy.global_position
	get_parent().add_child(new_bullet)
	new_bullet.position = enemy.position
	new_bullet.rotation = direction.angle()
