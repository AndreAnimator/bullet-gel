class_name HitBox
extends Area2D

@export var initial_damage = 1

signal damaged(attack: Attack)
signal shield_damaged(attack: Attack)
signal stunned(attack: Attack)

func damage(attack: Attack):
    damaged.emit(attack)

func shield_damage(attack: Attack):
    shield_damaged.emit(attack)

func stun(attack: Attack):
    stunned.emit(attack)

func change_mask_value(number: int, value: bool):
    set_collision_mask_value(number, value)

func change_layer_value(number: int, value: bool):
    set_collision_layer_value(number, value)