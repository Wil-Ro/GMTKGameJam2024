class_name Arm extends Node3D

@onready var camera: Camera3D = $"../../Camera3D"
@onready var target: Marker3D = $Target

@export var action: StringName

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Skeleton3D/PhysicalBoneSimulator3D.physical_bones_start_simulation()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func update_target_pos() -> void:
	var mouse_pos: Vector2 = camera.get_window().get_mouse_position()
	
	var origin: Vector3 = camera.project_ray_origin(mouse_pos)
	var dir: Vector3 = origin + (camera.project_ray_normal(mouse_pos) * 100)
	
	var world_space: PhysicsDirectSpaceState3D = camera.get_window().world_3d.direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.create(origin, dir)
	var collision: Dictionary = world_space.intersect_ray(ray_query)
	
	if collision == null: return
	
	var arm_target_pos: Vector3 = collision["position"]
	target.global_position = arm_target_pos
