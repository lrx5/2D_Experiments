extends Node2D

enum Direction { UP, DOWN, LEFT, RIGHT }
var current_direction
enum ControllerState { CONTROLLER, MOUSE }
var controller_state = ControllerState.MOUSE
var cell_size = Vector2(16, 16)
var screen_size = Vector2(160, 142)
var button_held = false
var repeat_move_bool = true
@onready var tile_map = get_node("/root/GridMovement/TileMapLayer")
@onready var camera = get_node("/root/GridMovement/Camera2D")
@onready var box_cursor = $BoxCursor
@onready var hold_timer: Timer = $HoldTimer
@onready var repeat_move: Timer = $RepeatMoveTimer

func _process(delta):
	if controller_state == ControllerState.MOUSE:
		mouse_cursor()
	controller_cursor(box_cursor)
	camera_follow_cursor(box_cursor)


#---------------Functions---------------#
func mouse_cursor():
	var cursor_pos = get_global_mouse_position()
	var tile_pos = tile_map.local_to_map(cursor_pos)
	var grid_world_pos = tile_map.map_to_local(tile_pos)
	box_cursor.position = grid_world_pos

func controller_cursor(_box_cursor):
	if Input.is_action_just_pressed("Right"):
		button_held = false
		change_control_enum()
		current_direction = Direction.RIGHT
		_box_cursor.position.x += 16
		hold_timer.start()
	elif Input.is_action_just_pressed("Left"):
		button_held = false
		change_control_enum()
		current_direction = Direction.LEFT
		_box_cursor.position.x -= 16
		hold_timer.start()
	elif Input.is_action_just_pressed("Down"):
		button_held = false
		change_control_enum()
		current_direction = Direction.DOWN
		_box_cursor.position.y += 16
		hold_timer.start()
	elif Input.is_action_just_pressed("Up"):
		button_held = false
		change_control_enum()
		current_direction = Direction.UP
		_box_cursor.position.y -= 16
		hold_timer.start()
	# Stop movement when buttons are released
	if Input.is_action_just_released("Right") or Input.is_action_just_released("Left") or Input.is_action_just_released("Up") or Input.is_action_just_released("Down"):
		hold_timer.stop()
		button_held = false

	if button_held and repeat_move_bool == true:
		if current_direction  == Direction.RIGHT:
			_box_cursor.position.x += 16
			repeat_move_bool = false
			repeat_move.start()
		if current_direction  == Direction.LEFT:
			_box_cursor.position.x -= 16
			repeat_move_bool = false
			repeat_move.start()
		if current_direction  == Direction.DOWN:
			_box_cursor.position.y += 16
			repeat_move_bool = false
			repeat_move.start()
		if current_direction  == Direction.UP:
			_box_cursor.position.y -= 16
			repeat_move_bool = false
			repeat_move.start()

func change_control_enum():
	controller_state = ControllerState.CONTROLLER

func camera_follow_cursor(_box_cursor):
	var camera_offset = camera.position - screen_size / 2
	if _box_cursor.position.x < camera_offset.x:
		camera.position.x -= cell_size.x
	elif _box_cursor.position.x > camera_offset.x + screen_size.x:
		camera.position.x += cell_size.x
	if _box_cursor.position.y < camera_offset.y:
		camera.position.y -= cell_size.y
	elif _box_cursor.position.y > camera_offset.y + screen_size.y:
		camera.position.y += cell_size.y

func _input(event):
	if event is InputEventMouseMotion:
		controller_state = ControllerState.MOUSE
func _on_hold_timer_timeout() -> void:
	button_held = true
	repeat_move_bool == true
func _on_repeat_move_timer_timeout() -> void:
	repeat_move_bool = true
