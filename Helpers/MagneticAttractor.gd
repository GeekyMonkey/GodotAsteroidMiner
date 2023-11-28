extends Node3D

@export var Strength: float = 1.0
@export var MaxDistance: float = 1.0

var rigid_body: RigidBody3D

func _ready() -> void:
	rigid_body = get_parent() as RigidBody3D

func _physics_process(delta: float) -> void:
	for player: Player in get_tree().get_nodes_in_group("Players"):
		var dir = player.global_position - self.global_position
		var dist = dir.length()
		if dist < MaxDistance:
			var force = Strength / (dist * dist)
			rigid_body.apply_central_impulse(dir.normalized() * force)
