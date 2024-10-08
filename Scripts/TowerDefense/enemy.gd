extends CharacterBody2D

@export var path_follow: PathFollow2D
@export var speed: float = 100.0
@export var health: int = 3

func _ready() -> void:
	path_follow = get_parent()

func _process(delta: float) -> void:
	if path_follow:
		path_follow.progress += speed * delta
		global_position = path_follow.global_position
		if path_follow.progress_ratio >= 1.0:
			queue_free()
	if health <= 0:
		die()

func die():
	queue_free()
