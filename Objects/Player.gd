extends RigidBody3D

@onready var thrust: MeshInstance3D = $Thrust

var speed := 4.0
var rotation_speed := 1000.0

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		apply_torque(Vector3(0,0,rotation_speed * -delta))
	elif Input.is_action_pressed("ui_left"):
		apply_torque(Vector3(0, 0, rotation_speed * delta))

	if Input.is_action_pressed("ui_up"):
		apply_central_force(transform.basis.y * speed)
		thrust.visible = true
	else:
		thrust.visible = false


