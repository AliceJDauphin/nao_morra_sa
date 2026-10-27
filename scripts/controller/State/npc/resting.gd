extends State

@export var parent : State_machine
@export var idle : State

@export var npc : NPC

@export var timer : Timer

func enter():
	if npc.friend == null:
		timer.start(npc.rest_time)
		npc.animation['parameters/conditions/resting'] = true
	else:
		npc.animation['parameters/conditions/chatting'] = true
		timer.start(npc.talking_time)
		#print(npc.position.direction_to(npc.friend.position).x)
		npc.direction = npc.position.direction_to(npc.friend.position).x / abs(npc.position.direction_to(npc.friend.position).x)
		 
	#print(time)
	
func exit():
	npc.friend = null
	npc.talking_time = 0
	npc.animation['parameters/conditions/chatting'] = false
	npc.animation['parameters/conditions/resting'] = false
	pass

func update(delta):
	pass

func physics_update(delta):
	pass

func _on_timer_timeout() -> void:
	parent.change_state(idle)
	pass # Replace with function body.
