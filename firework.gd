extends RigidBody3D

#button ref
@onready var button = $"../Button/ClickBox"

#model refs
@onready var shaft = $Shaft
@onready var stick = $Stick

#timer setups
@onready var fuse_timer = $FuseTimer
var fuse_per_dist = 0.25
@onready var charge_timer = $ChargeTimer
@onready var explosion_timer = $ExplosionTimer

#launch acceleration
var launched = false
var accel = 50.0

#particle refs
@onready var spark_particles = $SparkParticles
@onready var smoke_particles = $SmokeParticles
var explosion_particles : GPUParticles3D;


# Called when the node enters the scene tree for the first time.
func _ready():
	explosion_particles = get_child(randi_range(-7,-1))
	pass

func setup():
	button.ButtonPressed.connect(launch)
	var planar_dist = Vector3(position.x,0,position.z).distance_to(Vector3(button.global_position.x,0,button.global_position.z))
	fuse_timer.set_wait_time(planar_dist * fuse_per_dist)

func launch():
	if launched:
		return
	launched = true
	spark_particles.set_emitting(true)
	fuse_timer.start()

func _on_fuse_timer_timeout():
	freeze = false
	add_constant_force(Vector3.UP * accel)
	stick.visible = false
	smoke_particles.set_emitting(true)
	charge_timer.start()
	pass # Replace with function body.

func _on_charge_timer_timeout():
	freeze = true
	constant_force = Vector3.ZERO
	spark_particles.set_emitting(false)
	smoke_particles.set_emitting(false)
	explosion_particles.set_emitting(true)
	pass # Replace with function body.

func _on_explosion_timer_timeout():
	queue_free()
	pass # Replace with function body.

func _on_palm_effect_finished():
	print("palm finished")
	explosion_timer.start(5)
	pass # Replace with function body.

func _on_fish_effect_finished():
	print("fish finished")
	explosion_timer.start(5)
	pass # Replace with function body.

func _on_crackle_effect_finished():
	print("crackle finished")
	explosion_timer.start(5)
	pass # Replace with function body.
