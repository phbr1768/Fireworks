extends Node3D
@onready var animation_player = $"../AnimationPlayer"

signal ButtonPressed

func press():
	animation_player.play("press")
	print("button pressed")

func activate():
	ButtonPressed.emit()
