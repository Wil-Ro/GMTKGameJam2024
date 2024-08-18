@tool
extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var camera = get_viewport().get_camera_3d()
	if camera == null: return
	$smoke.set_global_rotation(get_global_rotation().direction_to(camera.get_global_position()))
