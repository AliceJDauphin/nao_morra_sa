extends StaticBody2D

@export_group("Nodes ")
@export var State_machine : State_machine
@export var npc_detector : Area2D
@export var attack_area : Area2D
@export var sprite : AnimatedSprite2D
@export var animation : AnimationTree

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
	State_machine.process(delta)

func _physics_process(delta: float) -> void:
	State_machine.physics_process(delta)
	
func npc_check():
	var close_npc = $npc_detector.get_overlapping_bodies()
	for bob in close_npc:
				if bob == self:
					close_npc.erase(bob)
				
	return close_npc
