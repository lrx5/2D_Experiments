extends Sprite2D

@export var step_target: Marker2D
@export var step_distance: float = 20.0
@export var adjacent_target: Sprite2D

var is_stepping = false

func _ready() -> void:	
	position = step_target.global_position
	top_level = true

func _process(delta: float) -> void:
	if !is_stepping and !adjacent_target.is_stepping and abs(global_position.distance_to(step_target.global_position)) > step_distance:
		step()

func step():
	var target_pos = step_target.global_position
	var half_way = (global_position + step_target.global_position) / 2
	is_stepping = true
	
	var tween = create_tween()
	tween.tween_property(self, "global_position", half_way, 0.5)
	tween.tween_property(self, "global_position", target_pos, 0.8)
	tween.tween_callback(func(): is_stepping = false)
