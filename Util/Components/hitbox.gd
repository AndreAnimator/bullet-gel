class_name HitBox
extends Area2D

@export var initial_damage = 1

signal damaged(attack: Attack)

func damage(attack: Attack):
    damaged.emit(attack)