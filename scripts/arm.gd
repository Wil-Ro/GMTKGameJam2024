class_name Arm extends Node3D

@export var action: StringName


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _arm_enabled(arm):
	print_debug("enabled!")
	pass

func _arm_disabled(arm):
	print_debug("disabled!")
	pass
