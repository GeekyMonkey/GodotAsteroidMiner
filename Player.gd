extends CharacterBody3D

@onready var thrust: MeshInstance3D = $Thrust

var speed := 10.0
var accel := 2.0
var rotation_speed := 6.0
#var velocity := Vector3.ZERO

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		rotate_z(-rotation_speed * delta)
	elif Input.is_action_pressed("ui_left"):
		rotate_z(rotation_speed * delta)

	if Input.is_action_pressed("ui_up"):
		velocity = velocity.move_toward(transform.basis.y * speed, accel * delta)
		thrust.visible = true
	else:
		velocity = velocity.move_toward(Vector3.ZERO, 0.1 * delta)
		thrust.visible = false

	move_and_slide()
