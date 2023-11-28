extends RigidBody3D
class_name Laser

const Sparks = preload("res://Objects/FX/Sparks.tscn")

@export var Speed: float = 20.0
@export var Life: float = 1.1

var Age: float = 0
var init: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	Init()
	Age += delta
	if Age > Life:
		queue_free()

func Init():
	if !init:
		init = true
		var forward_dir = transform.basis.y  # Get the forward direction
		set_linear_velocity(forward_dir * Speed)  # Set the velocity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	if state.get_contact_count() >= 1:
		var collisionPos = state.get_contact_collider_position(0)
		var impulse = state.get_contact_impulse(0)
		var force = impulse.length()

		var other = state.get_contact_collider_object(0)
		print("Laser collision at: " + str(collisionPos) + " @ " + str(force))
		if other is Asteroid:
			Events.LaserHitAsteroid.emit(self, other, collisionPos, force)
		else:
			print("Laser hit: " + other.name)

		var spark = Sparks.instantiate()
		spark.position = collisionPos
		get_parent().add_child(spark)
		queue_free()
