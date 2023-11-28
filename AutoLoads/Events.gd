extends Node

signal LaserHitAsteroid(laser: Laser, asteroid: Asteroid, position: Vector3, force: float)

signal PlayerHitAsteroid(player: Player, asteroid: Asteroid, position: Vector3, force: float)

signal GemCollected(position: Vector3)
