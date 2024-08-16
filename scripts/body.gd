class_name Body extends Node3D

@export var arms: Array[Arm]

signal arm_enabled(arm)
signal arm_disabled(arm)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for arm in arms:
		arm_enabled.connect(arm._arm_enabled)
		arm_disabled.connect(arm._arm_disabled)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	for arm in arms:
		if Input.is_action_just_pressed(arm.action):
			arm_enabled.emit(arm)
		if Input.is_action_just_released(arm.action):
			arm_disabled.emit(arm)
