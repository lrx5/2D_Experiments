extends Node2D

@export var bullet_scene: PackedScene
var body: CharacterBody2D
var direction
var timer_started = false
var enemy_in_range = false
@onready var shoot_timer: Timer = $ShootTimer
@onready var cannon_turret: Sprite2D = $CannonBase/CannonTurret

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if enemy_in_range:
		aim()
	if enemy_in_range and !timer_started:
		shoot()

func aim():
	direction = (body.global_position - global_position).normalized()
	cannon_turret.rotation = direction.angle() + deg_to_rad(90)

func shoot():
	timer_started = true
	shoot_timer.start()
func _on_shoot_timer_timeout() -> void:
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.global_position = cannon_turret.position
	add_child(bullet_instance)
	# Calculate the shoot direction based on cannon's rotation
	var shoot_direction = \
	Vector2(cos(cannon_turret.rotation - deg_to_rad(90)),\
	sin(cannon_turret.rotation - deg_to_rad(90))).normalized() 
	bullet_instance.set_velocity(shoot_direction)
	timer_started = false


func _on_tower_range_body_entered(body: CharacterBody2D) -> void:
	enemy_in_range = true
	self.body = body
func _on_tower_range_body_exited(body: Node2D) -> void:
	if self.body == body:
		enemy_in_range = false
		self.body = null
