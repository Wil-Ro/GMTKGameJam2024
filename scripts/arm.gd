class_name Arm extends Node3D

@onready var camera: Camera3D = $"../../Camera3D"
@onready var target: Marker3D = $Target
@onready var ik_skeleton: SkeletonIK3D = $Skeleton3D/SkeletonIK3D

@export var action: StringName

func _ready() -> void:
	#$Skeleton3D/PhysicalBoneSimulator3D.physical_bones_start_simulation()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#ik_skeleton.start()
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
	print(collision)
	target.global_position.z = arm_target_pos.z
	target.global_position.y = arm_target_pos.y
