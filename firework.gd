extends RigidBody3D

#button ref
@onready var button = $"../Button/ClickBox"

#model refs
@onready var shaft = $Shaft
@onready var stick = $Stick

#timer setups
@onready var fuse_timer = $FuseTimer
var fuse_per_dist = 0.5
@onready var charge_timer = $ChargeTimer
@onready var explosion_timer = $ExplosionTimer

#launch acceleration
var accel = 50.0

#particle refs
@onready var spark_particles = $SparkParticles
@onready var smoke_particles = $SmokeParticles
@onready var explosion_particles = $ExplosionParticles


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func setup():
	button.ButtonPressed.connect(launch)
	var planar_dist = Vector3(position.x,0,position.z).distance_to(Vector3(button.global_position.x,0,button.global_position.z))
	fuse_timer.set_wait_time(planar_dist * fuse_per_dist)

func launch():
	spark_particles.set_emitting(true)
	fuse_timer.start()

func _on_fuse_timer_timeout():
	freeze = false
	add_constant_force(Vector3.UP * accel)
	stick.visible = false
	spark_particles.set_emitting(false)
	smoke_particles.set_emitting(true)
	charge_timer.start()
	pass # Replace with function body.

func _on_charge_timer_timeout():
	freeze = true
	constant_force = Vector3.ZERO
	smoke_particles.set_emitting(false)
	explosion_particles.set_emitting(true)
	explosion_timer.start()
	pass # Replace with function body.

func _on_explosion_timer_timeout():
	queue_free()
	pass # Replace with function body.
