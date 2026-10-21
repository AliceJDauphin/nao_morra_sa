extends Node2D

const levels := ["uid://dudjymm4ofmwd"]

func _ready() -> void:
	get_tree().change_scene_to_file(levels[0])
	
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_restart"):
		print("Reloaded")
		get_tree().reload_current_scene()
