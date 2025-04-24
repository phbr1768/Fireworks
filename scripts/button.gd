extends Node3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal ButtonPressed

func press():
	animation_player.play("press")
