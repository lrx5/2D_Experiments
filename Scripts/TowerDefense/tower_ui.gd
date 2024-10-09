extends Control

@export var label: Label
var mode_counter = 0
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass


func _on_label_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("Left_Click"):
		mode_counter += 1
		if mode_counter == 4: mode_counter = 0
	match mode_counter:
		0:
			label.text = "FIRST"
		1:
			label.text = "LAST"
		2:
			label.text = "HIGH HP"
		3:
			label.text = "LOW HP"

func _on_label_mouse_entered() -> void:
	self.modulate.r = 0.5
func _on_label_mouse_exited() -> void:
	self.modulate.r = 1
