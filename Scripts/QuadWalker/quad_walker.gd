extends CharacterBody2D
@export var pod1 = Sprite2D
@export var pod2 = Sprite2D
@export var pod3 = Sprite2D
@export var pod4 = Sprite2D
@export var marker1 = Marker2D
@export var marker2 = Marker2D
@export var marker3 = Marker2D
@export var marker4 = Marker2D

@export var speed: float = 5.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	marker1.global_position = pod1.global_position
	marker2.global_position = pod2.global_position
	marker3.global_position = pod3.global_position
	marker4.global_position = pod4.global_position
	
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("Up"):
		direction.y -= 1
	if Input.is_action_pressed("Down"):
		direction.y += 1
	if Input.is_action_pressed("Left"):
		direction.x -= 1
	if Input.is_action_pressed("Right"):
		direction.x += 1
	
	if direction != Vector2.ZERO:
		direction = direction.normalized()
	
	velocity = direction * speed
	move_and_slide()
