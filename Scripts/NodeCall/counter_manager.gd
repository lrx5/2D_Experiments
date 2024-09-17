extends Node

var left_click = 0
var right_click = 0

@onready var counter: Label = $Counter

func _ready() -> void:
	update_counter()

func update_counter():
	counter.text = "Left Click: " + str(left_click) + "    Right Click: " + str(right_click)
func left_clicked():
	left_click += 1
	update_counter()
func right_clicked():
	right_click += 1
	update_counter()
