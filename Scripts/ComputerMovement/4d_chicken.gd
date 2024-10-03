extends CharacterBody2D

enum Direction { UP, DOWN, LEFT, RIGHT }
var speed = 40
var easing_speed = 5.0
var move_direction = Vector2.ZERO
var rng = RandomNumberGenerator.new()
@onready var stay_or_move_timer: Timer = $StayOrMoveTimer
@onready var stay_timer: Timer = $StayTimer

func _ready():
	rng.randomize()
	stay_or_move()

func _process(delta):
	velocity = lerp(velocity, move_direction * speed, delta * easing_speed)
	move_and_slide()

func stay_or_move():
	var mood = rng.randi_range(0, 3)
	if mood <= 1:
		stay()
	elif mood >= 2:
		move()

func stay():
	move_direction = Vector2.ZERO
	# Animation Idle
	stay_timer.start()
	
func _on_stay_timer_timeout() -> void:
	stay_or_move()

func move():
	pick_random_direction()
	# Animation Moving
	# Play SFX

func pick_random_direction():
	var direction = rng.randi_range(0, 3)
	match direction:
		Direction.UP:
			move_direction = Vector2(0, -1)  # Move up
		Direction.DOWN:
			move_direction = Vector2(0, 1)  # Move down
		Direction.LEFT:
			move_direction = Vector2(-1, 0)  # Move left
		Direction.RIGHT:
			move_direction = Vector2(1, 0)  # Move right
	stay_or_move_timer.start()

func _on_new_direction_timer_timeout() -> void:
	stay_or_move()
