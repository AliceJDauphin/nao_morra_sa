extends Node
class_name State_machine

@export var current_state : State

func ready() -> void:
	current_state.enter()

func change_state(state : State):
	current_state.exit()
	current_state = state
	current_state.enter()

func process(delta) -> void:
	current_state.update(delta)

func physics_process(delta) -> void:
	current_state.physics_update(delta)
