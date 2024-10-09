extends Node
var spawn_location
@export var soldier_scene: PackedScene
@export var armored_scene: PackedScene
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Right_Click"):
		spawn_soldier()
	if event.is_action_pressed("Left_Click"):
		spawn_armored()

func spawn_soldier():
	var soldier_instance = soldier_scene.instantiate()
	spawn_location = $"/root/TowerDefense/Path2D"
	spawn_location.add_child(soldier_instance)
func spawn_armored():
	var armored_instance = armored_scene.instantiate()
	spawn_location = $"/root/TowerDefense/Path2D"
	spawn_location.add_child(armored_instance)
