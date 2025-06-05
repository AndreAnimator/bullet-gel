class_name Health
extends Node

signal health_changed(health: float)

@export var hitbox: HitBox

@export var max_health := 10.0
@onready var health := max_health

# tenho que deixar isso genérico pra que aconteça com o player também?
# @onready var enemy = Enemy = get_owner

func _ready():
    if hitbox:
        hitbox.damaged.connect(on_damaged)

func on_damaged(attack: Attack):
    # if !enemy.alive:
        # return
    
    health -= attack.damage
    health_changed.emit(health)

    if health <= 0:
        health = 0
        # enemy.alive = false
