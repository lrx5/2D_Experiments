extends Node

@onready var counter_manager = get_node("/root/NodeCall/CounterManager")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Left_Click"):
		counter_manager.left_clicked()
	if Input.is_action_just_pressed("Right_Click"):
		counter_manager.right_clicked()
