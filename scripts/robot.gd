class_name Body extends Node3D

@export var arms: Array[Arm]
@export var body_offset: float = 0.25
@export var skeleton: Skeleton3D
@export var body_bone: StringName
@onready var previous_position: Vector3 = global_position

var active_arm: Arm

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
	
	active_arm.update_target_pos(delta)
	
	var avg_tip_pos: Vector3
	var avg_tip_basis: Basis
	
	for arm in arms:
		var tip_bone_global_pos: Vector3 = skeleton.to_global(arm.tip_bone_trans.origin)
		#var tip_bone_global_basis: Basis = arm.tip_bone_tras.basis
		
		avg_tip_pos += tip_bone_global_pos
		
		#avg_tip_basis.x += tip_bone_global_basis.x
		#avg_tip_basis.y += tip_bone_global_basis.y
		#avg_tip_basis.z += tip_bone_global_basis.z
		
	avg_tip_pos /= arms.size()
	#avg_tip_basis.x /= arms.size()
	#avg_tip_basis.y /= arms.size()
	#avg_tip_basis.z /= arms.size()
	
	#skeleton.global_position = avg_tip_pos
	#var m = MeshInstance3D.new()
	var body_bone_id: int = skeleton.find_bone(body_bone)
	var body_bone_transform = skeleton.get_bone_global_pose(body_bone_id)
	var velocity = global_position - previous_position
	print(global_position, previous_position, velocity, avg_tip_pos)
	var global_pos = avg_tip_pos + velocity * body_offset
	body_bone_transform.origin = global_pos
	skeleton.set_bone_global_pose(body_bone_id, body_bone_transform)
	previous_position = global_pos
	#m.global_position = avg_tip_pos
	#skeleton.global_basis = avg_tip_basis
