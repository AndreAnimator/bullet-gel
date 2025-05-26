extends Area2D

var velocity: Vector2 = Vector2()
var duration = 4000

func _ready() -> void:
    connect("body_entered", _on_body_entered)

func _process(delta: float) -> void:
    position += velocity * delta

    duration -= 1
    if duration == 0:
        queue_free()

func _on_body_entered(body):
    if body.is_in_group("player"):
        if !body.is_invincible():
            body.take_damage(1)
            queue_free()
    if body.is_in_group("solid"):
        queue_free()

