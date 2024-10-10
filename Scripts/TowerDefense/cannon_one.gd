extends Node2D

@export var bullet_scene: PackedScene
@export var targeting_mode: TargetingMode = TargetingMode.TARGET_FIRST  # Default targeting mode

enum TargetingMode {
	TARGET_FIRST,
	TARGET_LAST,
	TARGET_HIGHEST_HP,
	TARGET_LOWEST_HP,}

var current_target: CharacterBody2D
var direction
var timer_started = false
var enemy_in_range = false
@onready var shoot_timer: Timer = $ShootTimer
@onready var cannon_turret: Sprite2D = $CannonBase/CannonTurret
@onready var cannon_sfx: AudioStreamPlayer = $CannonSFX
var enemies_in_range: Array = []

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if current_target == null or current_target.health <= 0:
		enemies_in_range.erase(current_target)  # Remove the dead enemy from list
		find_next_target()
		if current_target == null:
			shoot_timer.stop()

	if enemy_in_range:
		aim()
	if enemy_in_range and !timer_started:
		shoot()

#region Aiming & Shooting
func aim():
	direction = (current_target.global_position - global_position).normalized()
	cannon_turret.rotation = direction.angle() + deg_to_rad(90)
func shoot():
	timer_started = true
	shoot_timer.start()
func _on_shoot_timer_timeout() -> void:
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.global_position = cannon_turret.position
	add_child(bullet_instance)

	var shoot_direction = Vector2(cos(cannon_turret.rotation - deg_to_rad(90)), sin(cannon_turret.rotation - deg_to_rad(90))).normalized() 
	bullet_instance.set_velocity(shoot_direction)
	timer_started = false
	play_sfx()
	find_next_target()
func play_sfx():
	cannon_sfx.play()
#endregion

#region On Body Enter & Exit

func _on_tower_range_body_entered(body: CharacterBody2D) -> void:
	enemies_in_range.append(body)
	if current_target == null:
		current_target = body
	enemy_in_range = true
func _on_tower_range_body_exited(body: Node2D) -> void:
	if body == current_target:
		current_target = null  # Reset the target if it's the one leaving
	enemy_in_range = enemies_in_range.size() > 0
	enemies_in_range.erase(body)
#endregion

func find_next_target() -> void:
	# If there are enemies in the array, find next target with the conditions
	if enemies_in_range.size() > 0:
		match targeting_mode:
			TargetingMode.TARGET_FIRST:
				current_target = get_first_enemy()
			TargetingMode.TARGET_LAST:
				current_target = get_last_enemy()
			TargetingMode.TARGET_HIGHEST_HP:
				current_target = get_highest_hp_enemy()
			TargetingMode.TARGET_LOWEST_HP:
				current_target = get_lowest_hp_enemy()
	else:
		current_target = null
		enemy_in_range = false
		timer_started = false

# Function to find the first enemy
func get_first_enemy() -> CharacterBody2D:
	var first_enemy: CharacterBody2D = enemies_in_range[0]
	for enemy in enemies_in_range:
		if enemy.distance_from_start > first_enemy.distance_from_start:
			first_enemy = enemy
	return first_enemy

# Function to find the enemy with the highest HP
func get_highest_hp_enemy() -> CharacterBody2D:
	var highest_hp_enemy: CharacterBody2D = enemies_in_range[0]
	for enemy in enemies_in_range:
		if enemy.health > highest_hp_enemy.health:
			highest_hp_enemy = enemy
	return highest_hp_enemy

# Function to find the enemy with the lowest HP
func get_lowest_hp_enemy() -> CharacterBody2D:
	var lowest_hp_enemy: CharacterBody2D = enemies_in_range[0]
	for enemy in enemies_in_range:
		if enemy.health < lowest_hp_enemy.health:
			lowest_hp_enemy = enemy
	return lowest_hp_enemy

# Function to find the last enemy
func get_last_enemy() -> CharacterBody2D:
	var last_enemy: CharacterBody2D = enemies_in_range[0]
	for enemy in enemies_in_range:
		if enemy.distance_from_start < last_enemy.distance_from_start:
			last_enemy = enemy
	return last_enemy
