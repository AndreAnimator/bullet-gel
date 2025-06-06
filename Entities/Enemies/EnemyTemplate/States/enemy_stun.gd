extends EnemyState

var timer : Timer

func enter():
	timer = Timer.new()
	timer.wait_time = 1.0
	timer.autostart = true
	timer.timeout.connect(on_timer_finished)
	add_child(timer)
	enemy.invincible = true

func exit():
	timer.stop()
	timer.timeout.disconnect(on_timer_finished)
	timer.queue_free()
	timer = null
	enemy.invincible = false

func on_timer_finished():
	if !try_chase():
		transitioned.emit(self, "chase")
