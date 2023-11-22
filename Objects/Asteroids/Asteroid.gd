extends RigidBody3D

@export var SpinSpeed: float = 100.0
@export var MoveSpeed: float = 10.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	RandomRotation()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func RandomRotation() -> void:
	var rand = RandomNumberGenerator.new()
	var randAngle = Vector3(rand.randf(), rand.randf(), rand.randf()).normalized()
	rotate_object_local(randAngle, rand.randf_range(0, PI*2))
	angular_velocity = randAngle * (rand.randf() * 2 - 1) * SpinSpeed
	linear_velocity = randAngle * (rand.randf() * 2 - 1) * MoveSpeed
