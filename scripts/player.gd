extends CharacterBody2D
class_name Pin

@export var movement: Movement
@export var dice: Dice
@export var navegator: Navegator

var moves_left = 0

func _ready() -> void:
	movement.movement_done.connect(movement_done)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		moves_left = roll_dice()
		print("dice: ", moves_left)
		do_movement()

func _input(event: InputEvent) -> void:
	pass


func roll_dice() -> int:
	return dice.roll()


func do_movement():
	if !moves_left:
		return
		
	var next_movement = navegator.get_movement(self.global_position)
	move_to(next_movement)


func movement_done():
	moves_left -=1
	do_movement()


func move_to(pos):
	movement.move_to(pos)
