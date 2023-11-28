extends RigidBody3D
class_name Asteroid

@export var SpinSpeed: float = 100.0
@export var MoveSpeed: float = 10.0
@export var EnergyStart: float = 100.0
@export var GemsStart: int = 10

var GemsEjected: int = 0
var Energy: float = 100.0

const Gem = preload("res://Objects/Pickups/Gem.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	RandomRotation()
	Events.LaserHitAsteroid.connect(LaserHitAsteroid)
	Energy = EnergyStart


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func RandomRotation() -> void:
	var rand = RandomNumberGenerator.new()
	var randAngle = Vector3(rand.randf(), rand.randf(), rand.randf()).normalized()
	rotate_object_local(randAngle, rand.randf_range(0, PI*2))
	angular_velocity = randAngle * (rand.randf() * 2 - 1) * SpinSpeed
	linear_velocity = randAngle * (rand.randf() * 2 - 1) * MoveSpeed

func LaserHitAsteroid(laser: Laser, asteroid: Asteroid, pos: Vector3, force: float) -> void:
	if asteroid == self:
		Energy -= force
		while (float(GemsEjected) / float(GemsStart)) < ((EnergyStart - Energy) / EnergyStart):
			GemsEjected += 1
			var gem = Gem.instantiate()
			get_parent().add_child(gem)
			gem.global_position = pos
			gem.global_position.z = 0
			gem.linear_velocity = Vector3(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0), 0)
			gem.angular_velocity = Vector3(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))

			if GemsEjected == GemsStart:
				queue_free()
				# ToDo: Spawn smaller asteroids
