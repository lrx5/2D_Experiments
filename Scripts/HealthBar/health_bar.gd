extends ProgressBar

var health = 0.0 : set = _set_health
var current_health_displayed = 0.0
var current_damage_displayed = 0.0
var easing_speed = 20.0
var update_damage_bar = false
@onready var timer: Timer = $Timer
@onready var damage_bar: ProgressBar = $DamageBar

func _ready() -> void:
	init_health(20.0)
	current_health_displayed = health
	current_damage_displayed = health

func _process(delta):
	current_health_displayed = lerp(current_health_displayed, health, delta * easing_speed)
	value = current_health_displayed
	
	if update_damage_bar:
		current_damage_displayed = lerp(current_damage_displayed, health, delta * easing_speed)
		damage_bar.value = current_damage_displayed

	if damage_bar.value == value:
		update_damage_bar = false
	
func _set_health(new_health):
	var prev_health = health
	health = min(max_value, new_health)
	
	if health <= 0:
		queue_free()
	if health < prev_health:
		timer.start()
	else:
		damage_bar.value = health

func init_health(_health):
	health = _health
	max_value = health
	value = health
	damage_bar.max_value = health
	damage_bar.value = health

func _on_timer_timeout() -> void:
	#damage_bar.value = health
	update_damage_bar = true
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Left_Click"):
		health -= 1
	if event.is_action_pressed("Right_Click"):
		health += 1
