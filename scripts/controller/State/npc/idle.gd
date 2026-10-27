extends State

@export var timer : Timer
@export var parent : State_machine
@export var npc : NPC
@onready var SPEED := npc.SPEED
@export var rest : State

var pos_final : Vector2
var bonk : float = false
var distance : float
var speed : int

func enter():
	npc.animation['parameters/conditions/idle'] = true
	timer.start(randi_range(3,10))
	pass
	
func exit():
	npc.animation['parameters/conditions/idle'] = false
	npc.velocity.x = 0
	pass

func update(delta):
	pass

func physics_update(delta):
	if abs(npc.global_position.distance_to(pos_final)) > 10 && !bonk:
		npc.velocity.x = speed * npc.direction
		#print()
		if npc.wall_check() == -npc.direction:
			bonk = true
	else:
		##print("parei :) ")
		npc.velocity.x = 0
	pass
	
func _on_timer_timeout() -> void:
	if randi_range(1,3) >= 3:
		if rest:
			var close_npc :Array = npc.npc_check()
			if close_npc.size() == 1:
				var chat_time = randi_range(npc.min_chat_time,npc.max_chat_time)
				for bob in close_npc:
					if bob != npc:
						bob.emit_signal("start_chatting", npc, chat_time)
				npc.emit_signal("start_chatting", close_npc.pick_random(), chat_time)
			else:
				var rest_time = randi_range(npc.min_rest_time,npc.max_rest_time)
				npc.rest_time = rest_time
				parent.change_state(rest)
	else:
		var wall_check = npc.wall_check()
		distance = randi_range(50,100)
		#print(wall_check)
		if wall_check != 0:
			npc.direction = wall_check 
		else:
			npc.direction = [1,-1].pick_random()	
		pos_final = Vector2(npc.position.x + (npc.direction * distance), npc.position.y)
		speed = npc.SPEED * npc.SPEED_MOD.pick_random()
		bonk = false
		timer.start(randi_range(3,10))
	pass # Replace with function body.
