extends RigidBody3D
class_name Player

@onready var thrustMesh: MeshInstance3D = $Thrust
@onready var thrust_sound: AudioStreamPlayer3D = $Thrust/ThrustSound
@onready var gun_position: Marker3D = $GunPosition

const Laser = preload("res://Objects/FX/Laser.tscn")

@export_category("Physics")
@export var collisionThreshold: float = 1.0

@export_category("Controls")
@export var speed := 4.0
@export var rotation_speed := 1000.0


func _ready() -> void:
	body_entered.connect(on_body_entered)

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		apply_torque(Vector3(0,0,rotation_speed * -delta))
	elif Input.is_action_pressed("ui_left"):
		apply_torque(Vector3(0, 0, rotation_speed * delta))

	if Input.is_action_pressed("ui_up"):
		apply_central_force(transform.basis.y * speed)
		thrustMesh.visible = true
		thrust_sound.volume_db = lerp(thrust_sound.volume_db, 40.0, delta * 10)
	else:
		thrustMesh.visible = false
		thrust_sound.volume_db = lerp(thrust_sound.volume_db, -80.0, delta * 10)

	if Input.is_action_just_pressed("Shoot"):
		Shoot()

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	if state.get_contact_count() >= 1:
		var collisionPos = state.get_contact_collider_position(0)
		var impulse = state.get_contact_impulse(0)
		var force = impulse.length()

		var other = state.get_contact_collider_object(0)
		if force > collisionThreshold and other:
			# print("Collision at: " + str(collisionPos) + " @ " + str(force))
			if other is Asteroid:
				Events.PlayerHitAsteroid.emit(self, other, collisionPos, force)
			else:
				print("Player hit: " + other.name)


func on_body_entered(_other: PhysicsBody3D) -> void:
	#print("Collision occurred at: " + str(collisionPos) + " @ " + str(collisionImp) + " @ " + str(collisionForce))

	#if other is Asteroid:
		#Events.PlayerHitAsteroid.emit(self, other)
	#else:
		#print("Player hit: " + other.name)
	pass


func Shoot() -> void:
	var laser = Laser.instantiate()
	get_parent().add_child(laser)
	laser.global_position = gun_position.global_position
	laser.rotation = gun_position.global_rotation
