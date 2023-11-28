extends RigidBody3D
class_name Gem

@onready var gem_mesh: MeshInstance3D = $GemMesh

var gemTimer: float = 0
var gemInterval: float = 0.05

@export var Life: float = 10.0

var Age: float = 0
var mat: Material

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mat = gem_mesh.get_surface_override_material(0).duplicate()
	gem_mesh.set_surface_override_material(0, mat)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	gemTimer += delta
	if gemTimer > gemInterval:
		gemTimer = 0
		ChangeThrustMaterial()
	Age += delta
	if Age > Life:
		queue_free()

func ChangeThrustMaterial() -> void:
	# mat.emission_energy = randf_range(0, (Life - Age))
	mat.emission_energy = (Life - Age) / 10.0

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	if state.get_contact_count() >= 1:
		var collisionPos = state.get_contact_collider_position(0)
		var other = state.get_contact_collider_object(0)
		if other is Player:
			Events.GemCollected.emit(collisionPos)
			queue_free()
