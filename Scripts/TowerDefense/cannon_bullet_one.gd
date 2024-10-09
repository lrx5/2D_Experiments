extends Node2D

var bullet_speed = 1500.0
var velocity: Vector2 = Vector2.ZERO
@export var lifetime: float = 1.0
@onready var lifetime_timer: Timer = $LifetimeTimer

func _ready() -> void:
	lifetime_timer.wait_time = lifetime
	lifetime_timer.start()
	
func _process(delta: float) -> void:
	lifetime_timer.wait_time = lifetime
	position += velocity * bullet_speed * delta
	
func set_velocity(new_velocity: Vector2) -> void:
	velocity = new_velocity

func _on_lifetime_timer_timeout() -> void:
	queue_free()
func _on_bullet_area_body_entered(body: Node2D) -> void:
	body.health -= 1
	queue_free()
