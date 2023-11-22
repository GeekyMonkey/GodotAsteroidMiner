extends Node3D
class_name WorldWrapper

func _physics_process(_delta: float) -> void:
	var cam = get_viewport().get_camera_3d()
	var camSize = cam.size

	var s: Vector2 = get_viewport().size
	var aspect: float = s.x / s.y

	var worldSize: Vector2 = Vector2(camSize * aspect, camSize) # ViewportExtensions.Size()
	var worldMinX: float = worldSize.x / -2
	var worldMaxX: float = worldSize.x / 2
	var worldMinY: float = worldSize.y / -2
	var worldMaxY: float = worldSize.y / 2

	var parentNode: Node3D = get_parent_node_3d()
	while parentNode.global_position.x < worldMinX:
		parentNode.global_position.x += worldSize.x
	while parentNode.global_position.x > worldMaxX:
		parentNode.global_position.x -= worldSize.x
	while parentNode.global_position.y < worldMinY:
		parentNode.global_position.y += worldSize.y
	while parentNode.global_position.y > worldMaxY:
		parentNode.global_position.y -= worldSize.y
