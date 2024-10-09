extends Area2D

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("Right_Click"):
		print("Clicked!")
	var TowerUI = get_node("/root/CanvasLayer/TowerUI")
	TowerUI.global_position = global_position
