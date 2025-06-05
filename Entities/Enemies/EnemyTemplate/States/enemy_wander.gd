extends EnemyState

@export var min_wander_time := 2.5
@export var max_wander_time := 10.0
@export var wander_speed := 50.0

var wander_direction : Vector2

var wander_timer : Timer

func enter():
    print("Ta wander")
    wander_direction = Vector2.UP.rotated(deg_to_rad(randf_range(0, 360)))
    wander_timer = Timer.new()
    wander_timer.wait_time = randf_range(min_wander_time, max_wander_time)
    wander_timer.timeout.connect(on_timer_finished)
    wander_timer.autostart = true
    add_child(wander_timer)

func physics_process_state(delta: float):
    print("da wander")
    enemy.velocity = wander_direction*wander_speed
    enemy.move_and_slide()
    print("wandering")

    try_chase()
    print("Tenta persegui")

func on_timer_finished():
    transitioned.emit(self, "idle")
    print("Vai pra idle")

func exit():
    print("Saiu do wander")
    wander_timer.stop()
    wander_timer.timeout.disconnect(on_timer_finished)
    wander_timer.queue_free()
    wander_timer = null
