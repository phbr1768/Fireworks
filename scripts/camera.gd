extends Camera3D
# this script controls the player camera through rotating the player and tilting their head

@export var SENSITIVITY_X : float = 0.02
@export var SENSITIVITY_Y : float = 0.02

@onready var camera_holder = $".."
@onready var camera_3d = $"."

func _ready():
	# capture and hide mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		#grab motion of mouse and rotate camera
		camera_holder.rotate_y(-event.relative.x * SENSITIVITY_X)
		camera_3d.rotate_x(-event.relative.y * SENSITIVITY_Y)
		#clamp the rotation so that it doesnt flip upside down
		camera_3d.rotation.x = clamp(camera_3d.rotation.x, deg_to_rad(-80), deg_to_rad(80))

func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
