extends Node3D
signal scored(name)

@export var title: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$fire_particles/smoke.emitting = false
	$fire_particles/glow.emitting = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ActivateBackLeft"):
		put_to_rest()
	
func put_to_rest():
	burst()
	scored.emit(title)


func burst():
	$fire_particles/smoke.emitting = true
	$fire_particles/glow.emitting = true
	$person.hide()
	$burst_length_timer.start()


func _on_burst_length_timer_timeout() -> void:
	$fire_particles/smoke.emitting = false
	$fire_particles/glow.emitting = false
