extends Node3D

const Sparks = preload("res://Objects/FX/Sparks.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.PlayerHitAsteroid.connect(PlayerHitAsteroid)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func PlayerHitAsteroid(player, asteroid, pos, force):
	if force > 1.0:
		var spark = Sparks.instantiate()
		pos.z = 0
		spark.global_position = pos
		add_child(spark)

