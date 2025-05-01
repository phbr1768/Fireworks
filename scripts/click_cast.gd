extends RayCast3D

@onready var click_box = $"../../../Button/ClickBox"
var obj_hit
@onready var canvas_layer = $"../../CanvasLayer"
@onready var ground = $"../../../MapGeometry/Ground/StaticBody3D"
@onready var surface_point = $"../../../SurfacePoint"
@onready var world = $"../../.."

const FIREWORK = preload("res://scenes/firework.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	obj_hit = get_collider()
	if obj_hit == null:
		surface_point.visible = false
		canvas_layer.visible = false
		return
	canvas_layer.visible = obj_hit == click_box
	surface_point.position = get_collision_point()
	surface_point.visible = obj_hit == ground
	
	if Input.is_action_just_pressed("interact"):
		print("click")
		print(obj_hit)
		if obj_hit == click_box:
			click_box.press()
		elif obj_hit == ground:
			var firework = FIREWORK.instantiate()
			world.add_child(firework)
			firework.position = get_collision_point()
			firework.setup()
			pass
	pass
