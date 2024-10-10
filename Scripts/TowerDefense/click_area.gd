extends Area2D

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("Left_Click"):
		set_ui_position()
		set_turret_details()

func set_ui_position():
	var TowerUI = get_node("/root/TowerDefense/UI/TowerUI")
	TowerUI.position = global_position

func set_turret_details():
	var TowerUI = get_node("/root/TowerDefense/UI/TowerUI")
	var turret_node = get_parent()
	TowerUI.selected_tower = turret_node
	TowerUI.targeting_mode = turret_node.targeting_mode
	TowerUI.set_targeting_mode()
