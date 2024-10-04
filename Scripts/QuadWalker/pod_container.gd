extends Node2D

@export var offset: float = 100.0
@onready var parent = get_parent()
@onready var previous_position = parent.global_position


func _process(delta: float) -> void:
	var velocity = parent.global_position - previous_position
	global_position = parent.global_position + velocity * offset

	previous_position = parent.global_position
