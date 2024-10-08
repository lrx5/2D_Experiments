extends Node
var spawn_location
@export var enemy_scene: PackedScene
@export var path_follow: PathFollow2D
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Right_Click"):
		spawn_enemy()

func spawn_enemy():
	var enemy_instance = enemy_scene.instantiate()
	spawn_location = $"/root/TowerDefense/Path2D"
	spawn_location.add_child(enemy_instance)
