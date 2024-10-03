extends Node

#Exports are powerful!
@export var health_bar_scene: PackedScene
#@onready var counter_manager = get_node("/root/NodeCall/CounterManager")
@export var counter_manager = Node

func _ready() -> void:
	spawn_health_bar()

func spawn_health_bar():
	var health_bar_instance = health_bar_scene.instantiate()
	add_child(health_bar_instance)
	
	#To Get a node from a Scene, especially an instanced one
	#Both of these do the same thing of getting the node
	#var healthbarNode = health_bar_instance.get_node_or_null("/root/NodeCall/StaticPlayer/HealthBar")
	var healthbarNode = get_tree().get_root().get_node("NodeCall/StaticPlayer/HealthBar")
	healthbarNode.visible = false
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Left_Click"):
		counter_manager.left_clicked()
	if Input.is_action_just_pressed("Right_Click"):
		counter_manager.right_clicked()
