extends Line2D

@export var base: Sprite2D
@export var target: Marker2D
@export var line: Line2D

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	update_line()

func update_line():
	line.points = [base.position, target.position]
