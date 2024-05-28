extends Node2D
class_name Navegator

@export var board: TileMap

var cell_right: Vector2
var cell_left: Vector2
var cell_top: Vector2
var cell_bottom: Vector2
var last_direction: Vector2 = Vector2.RIGHT

var pos_right: Vector2
var pos_left: Vector2
var pos_top: Vector2
var pos_bottom: Vector2

func _ready() -> void:
	var cell_size: Vector2i = board.tile_set.tile_size
	cell_right = Vector2(cell_size.x, 0)
	cell_left = Vector2(-cell_size.x, 0)
	cell_top = Vector2(0, -cell_size.y)
	cell_bottom = Vector2(0, cell_size.y)

func _process(delta: float) -> void:
	pass

func is_floor(cell_position):
	var cell = board.local_to_map(cell_position)
	var data = board.get_cell_tile_data(0, cell)
	return data and data.get_custom_data("type") == "floor"

func calculate_positions(base_position: Vector2):
	pos_right = base_position + cell_right
	pos_left = base_position + cell_left
	pos_top = base_position + cell_top
	pos_bottom = base_position + cell_bottom


func get_direction_priority(base_position: Vector2):
	calculate_positions(base_position)
	
	match last_direction:
		Vector2.RIGHT:
			return [pos_right, pos_bottom, pos_top, pos_left]
		Vector2.LEFT:
			return [pos_left, pos_top, pos_bottom, pos_right]
		Vector2.UP:
			return [pos_top, pos_left, pos_right, pos_bottom]
		Vector2.DOWN:
			return [pos_bottom, pos_left, pos_right, pos_top]


func update_last_direction(new_position):
	match new_position:
		pos_right:
			last_direction = Vector2.RIGHT
		pos_left:
			last_direction = Vector2.LEFT
		pos_top:
			last_direction = Vector2.UP
		pos_bottom:
			last_direction = Vector2.DOWN
	

func get_movement(current_position: Vector2):
	var directions = get_direction_priority(current_position)
	
	for d in directions:
		if is_floor(d):
			update_last_direction(d)
			return d
