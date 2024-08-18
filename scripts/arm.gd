@tool

class_name Arm extends SkeletonIK3D

@onready var ik_target = get_node(target_node)
@onready var skeleton: Skeleton3D = get_parent_skeleton()

@export var action: StringName
@export var move_speed: float = 1.5

var input_dir: Vector2
var tip_bone_trans: Transform3D

func _ready() -> void:
	modification_processed.connect(_on_modification_processed)
	
	start()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		input_dir = event.relative

func update_target_pos(delta: float) -> void:
	ik_target.global_position.z -= input_dir.x * delta * move_speed
	ik_target.global_position.y -= input_dir.y * delta * move_speed
	input_dir = Vector2.ZERO

func _on_modification_processed() -> void:
	var tip_bone_id: int = skeleton.find_bone(tip_bone)
	tip_bone_trans = skeleton.get_bone_global_pose(tip_bone_id)
