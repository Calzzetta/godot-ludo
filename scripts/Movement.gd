extends Node2D
class_name Movement

@export var character_to_move: CharacterBody2D
signal movement_done


func _ready() -> void:
	pass


func _physics_process(delta):
	character_to_move.move_and_slide()


func movement_done_emit():
	movement_done.emit()


func move_to(pos: Vector2):
	var tween: Tween = create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(character_to_move, "position", pos, 0.5)
	tween.tween_callback(movement_done_emit)
