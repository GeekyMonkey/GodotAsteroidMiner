extends Node3D
class_name PlayerStats

@export var player: Player
@export var health: float = 100.0
@export var health_label: Label
@export var score: int = 0
@onready var score_label: Label = $CanvasLayer/MarginContainer/VBoxContainer/ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if health_label:
		health_label.text = "Health: 100"

	print("Connecting Event " + get_parent().name)
	Events.PlayerHitAsteroid.connect(
		func(_player: Player, _asteroid: Asteroid, _position: Vector3, force: float):
			health -= force
			print("Health: " + str(int(health)))
			if health_label:
				health_label.text = "Health: " + str(int(health))
	)

	Events.GemCollected.connect(
		func(pos: Vector3):
			score += 1
			print("Gem collected. Score = " + str(score))
			if score_label:
				score_label.text = "Score: " + str(score)
	)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
