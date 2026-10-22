extends CharacterBody2D
class_name NPC 

signal start_chatting(npc)

@export_group("Nodes ")
@export var State_machine : State_machine
@export var npc_detector : Area2D
@export var sprite : AnimatedSprite2D
@export var animation : AnimationTree

var friend : CharacterBody2D = null
var talking_time : int = 0
var rest_time : int = 0
var direction : int = 1

@export_group("Stats")
@export var SPEED : float
@export var SPEED_MOD : Array[float]
@export var MIN_FALL_DAMAGE : float
@export_subgroup("Timers")
@export var max_rest_time : int
@export var min_rest_time : int
@export var max_chat_time : int
@export var min_chat_time : int

func _ready() -> void:
	State_machine.ready()

func _process(delta: float) -> void:
	sprite.scale.x = direction
	$Label.text = str(name)
	$Label2.text = animation.get('parameters/playback').get_current_node()
	$Label3.text = State_machine.current_state.name
	##print(animation['parameters/conditions/chatting'])
	State_machine.process(delta)

func _physics_process(delta: float) -> void:
	State_machine.physics_process(delta)
	var fall_speed := 0.0
	if not is_on_floor():
		fall_speed = velocity.y
		velocity += get_gravity() * delta 		
	move_and_slide()
	if is_on_floor_only() and fall_speed > MIN_FALL_DAMAGE:
		print("ouch")

func wall_check():
	if $R_wall_checker.is_colliding():
		return -1
	elif $L_wall_checker.is_colliding():
		return 1
	else: return 0

func npc_check():
	var close_npc = $npc_detector.get_overlapping_bodies()
	for bob in close_npc:
				if bob == self:
					close_npc.erase(bob)
				
	return close_npc
	
func _on_start_chatting(npc : CharacterBody2D, time : int) -> void:
	friend = npc
	talking_time = time
	State_machine.change_state($State_machine/Resting)
