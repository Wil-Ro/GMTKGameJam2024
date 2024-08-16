class_name Body extends Node3D

@export var arms: Array[Arm]
@export var pull_strength: float = 5.0

var active_arm: Arm

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_input(event: InputEvent) -> void:
	for arm in arms:
		if Input.is_action_pressed(arm.action):
			active_arm = arm
			return
		if Input.is_action_just_released(arm.action):
			active_arm = null
			return

func _physics_process(delta: float) -> void:
	if active_arm == null: return
	
	active_arm.update_target_pos()
