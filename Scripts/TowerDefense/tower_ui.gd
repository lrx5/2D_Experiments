extends Control

@export var label: Label
var selected_tower: Node2D
var mode_counter: int
var targeting_mode

enum TargetingMode {
	TARGET_FIRST,
	TARGET_LAST,
	TARGET_HIGHEST_HP,
	TARGET_LOWEST_HP,}

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func set_targeting_mode():
	match targeting_mode:
		TargetingMode.TARGET_FIRST:
			mode_counter = 0
			label.text = "FIRST"
		TargetingMode.TARGET_LAST:
			mode_counter = 1
			label.text = "LAST"
		TargetingMode.TARGET_HIGHEST_HP:
			mode_counter = 2
			label.text = "HIGH HP"
		TargetingMode.TARGET_LOWEST_HP:
			mode_counter = 3
			label.text = "LOW HP"

func _on_label_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("Left_Click"):
		mode_counter += 1
		if mode_counter == 4: mode_counter = 0
	match mode_counter:
		0:
			label.text = "FIRST"
			set_new_targeting(TargetingMode.TARGET_FIRST)
		1:
			label.text = "LAST"
			set_new_targeting(TargetingMode.TARGET_LAST)
		2:
			label.text = "HIGH HP"
			set_new_targeting(TargetingMode.TARGET_HIGHEST_HP)
		3:
			label.text = "LOW HP"
			set_new_targeting(TargetingMode.TARGET_LOWEST_HP)

func set_new_targeting(new_targeting_mode):
	selected_tower.targeting_mode = new_targeting_mode

func _on_label_mouse_entered() -> void:
	self.modulate.r = 0.5
func _on_label_mouse_exited() -> void:
	self.modulate.r = 1
