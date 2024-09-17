extends CanvasLayer

@onready var name_label: RichTextLabel = $Control/NinePatchRect/Name
@onready var chat_label: RichTextLabel = $Control/NinePatchRect/Chat
var dialogues
var person = "npc2"
var current_dialogue_id = 1

func _ready():
	load_dialogue()
	display_dialogue(current_dialogue_id)

func load_dialogue():
	var file = FileAccess.open("res://Dialogues/dialogue_test.json", FileAccess.READ)
	dialogues = JSON.parse_string(file.get_as_text())
	file.close()

func get_dialogue_by_id(dialogue_id: int) -> Dictionary:
	for dialogue in dialogues[person]:
		if dialogue["id"] == dialogue_id:
			return dialogue
	return {}

func display_dialogue(dialogue_id: int):
	var dialogue = get_dialogue_by_id(dialogue_id)
	
	if dialogue:
		name_label.text = dialogue["name"]
		chat_label.text = dialogue["text"]
		
		# Handle next dialogue
		if dialogue["next"]:
			current_dialogue_id = dialogue["next"]
		else:
			current_dialogue_id = -1 # End of dialogue

func _input(event):
	if event.is_action_pressed("Left_Click"):
		if current_dialogue_id != -1:
			display_dialogue(current_dialogue_id)
		else:
			print("Dialogue finished!")
