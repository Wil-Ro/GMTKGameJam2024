@tool
extends Control


@export var background: Texture2D
@export var foreground: Texture2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$background.texture = background
	$foreground.texture = foreground
	
	$AnimationPlayer.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
