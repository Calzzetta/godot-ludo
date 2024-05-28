extends Node2D
class_name Dice


@export var faces: int = 6


func roll() -> int:
	return randi_range(1, faces)
