extends MeshInstance3D

var thrustTimer: float = 0
var thrustInterval: float = 0.05


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	thrustTimer += delta
	if thrustTimer > thrustInterval:
		thrustTimer = 0
		ChangeThrustMaterial()

func ChangeThrustMaterial() -> void:
	var mat = get_surface_override_material(0)
	mat.emission_energy = randf_range(0, 5)
