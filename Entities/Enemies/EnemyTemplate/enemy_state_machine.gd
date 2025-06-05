extends Node

@export var initial_state : EnemyState

var current_state : EnemyState
var states : Dictionary = {}

func _ready():
	print("e esse state machine q n faz nada")
	for child in get_children():
		if child is EnemyState:
			print("O nome  da criança " + child.name.to_lower())
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transition)
	
	if initial_state:
		current_state = initial_state
		current_state.enter()

func _process(delta):
	if current_state:
		print("oxi")
		current_state.process_state(delta)

func _physics_process(delta):
	if current_state:
		current_state.physics_process_state(delta)

func on_child_transition(state: EnemyState, new_state_name: String):
	print("Criança transicionou")
	if state != current_state:
		print("deferente")
		print(state)
		print(" != ")
		print(current_state)
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		print("não é state")
		return
	
	if current_state:
		print("Sai do state")
		current_state.exit()
	
	new_state.enter()
	print("Entra no state")
	current_state = new_state
