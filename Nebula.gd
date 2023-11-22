extends Sprite3D

@onready var player: RigidBody3D = $"../Player"

@export var paralax: float = 0.9

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#global_position.x = player.global_position.x * paralax
	#global_position.y = player.global_position.y * paralax
	pass
