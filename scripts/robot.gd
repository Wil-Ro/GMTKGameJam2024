@tool

class_name Body extends Node3D

@export var arms: Array[Arm]
@export var body_offset: float = 0.25
@export var skeleton: Skeleton3D
@export var body_bone: StringName
@export var move_speed: float = 0.5

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
		avg_tip_pos += tip_bone_global_pos
		
	avg_tip_pos /= arms.size()
	
   #skeleton.global_position = avg_tip_pos
	#var m = MeshInstance3D.new()
	var body_bone_id: int = skeleton.find_bone(body_bone)
	var body_bone_transform = skeleton.get_bone_global_pose(body_bone_id)
	var global_pos = skeleton.to_local(avg_tip_pos)# + velocity
	body_bone_transform.origin = global_pos
	skeleton.set_bone_global_pose(body_bone_id, body_bone_transform)
	
	# terrible code but its a jam so fuck it
	var br = skeleton.to_global(arms[0].tip_bone_trans.origin)
	var fr = skeleton.to_global(arms[1].tip_bone_trans.origin)
	var fl = skeleton.to_global(arms[2].tip_bone_trans.origin)
	var bl = skeleton.to_global(arms[3].tip_bone_trans.origin)
	
	var plane1 = Plane(bl, fl, fr)
	var plane2 = Plane(fr, br, bl)
	var normal_avg = ((plane1.normal + plane2.normal) / 2).normalized()
	
	var basis = Basis()
	
	basis.x = normal_avg.cross(skeleton.transform.basis.z)
	basis.y = normal_avg
	basis.z = skeleton.transform.basis.x.cross(normal_avg)
	
	print(bl, fl, fr)
	
	basis = basis.orthonormalized()
	
	var target_basis = basis
	skeleton.transform.basis = lerp(skeleton.transform.basis, target_basis, move_speed * delta).orthonormalized()
