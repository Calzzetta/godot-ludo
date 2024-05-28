extends CharacterBody2D
class_name Pin

@export var movement: Movement
@export var dice: Dice
@export var navegator: Navegator


var is_moving: bool = false
var moves_left: int = 0:
	set (value):
		moves_left = set_moves_left(value)


func _ready() -> void:
	movement.movement_done.connect(movement_done)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if !is_moving:
			moves_left = roll_dice()
			print("dice: ", moves_left)
			do_movement()


func set_moves_left(value: int):
	is_moving = value > 0
	return value


func roll_dice() -> int:
	return dice.roll()


func do_movement():
	if !is_moving:
		return
		
	var next_movement = navegator.get_movement(self.global_position)
	move_to(next_movement)


func movement_done():
	moves_left -=1
	do_movement()


func move_to(pos):
	movement.move_to(pos)
