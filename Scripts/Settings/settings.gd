extends Control

@export var bus_name_bgm: String
@export var bus_name_sfx: String
var bus_index_bgm: int
var bus_index_sfx: int
@onready var bgm: AudioStreamPlayer = $BGM
@onready var sfx: AudioStreamPlayer = $SFX


func _ready() -> void:
	bus_index_bgm = AudioServer.get_bus_index(bus_name_bgm)
	bus_index_sfx = AudioServer.get_bus_index(bus_name_sfx)
func _on_value_changed_bgm(value: float) -> void:
	AudioServer.set_bus_volume_db(
		bus_index_bgm,
		linear_to_db(value)
	)

func _on_value_changed_sfx(value: float) -> void:
	AudioServer.set_bus_volume_db(
		bus_index_sfx,
		linear_to_db(value)
	)
