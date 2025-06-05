class_name EnemyState
extends Node

signal transitioned(state: EnemyState, new_state_name: String)

@onready var enemy : Enemy = get_owner()
var player : Player

func _ready():
    print("Ready")
    player = get_tree().get_first_node_in_group("player")
    print("Pegou o Player")
    print(player)
    enemy.damaged.connect(on_damaged)

func enter():
    pass

func process_state(delta: float):
    pass

func physics_process_state(delta: float):
    pass

func exit():
    pass

func try_chase() -> bool:
    if get_distance_to_player() <= enemy.detection_radius:
        transitioned.emit(self, "chase")
        return true
    return false

func get_distance_to_player() -> float:
    return player.global_position.distance_to(enemy.global_position)

func on_damaged(attack: Attack):
    transitioned.emit(self, "stun")