extends Label


func _physics_process(delta: float) -> void:
	var mouse_pos : Vector2 = get_global_mouse_position()
	
	self.position = mouse_pos
	self.text = str(mouse_pos)
