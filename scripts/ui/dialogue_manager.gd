extends Control

@export var dialogue: Dialogue

@export var name_box: Label 
@export var text_box: Label 

var current_message := 0


func _ready() -> void:
	display_next_message()


func display_next_message() -> void:
	name_box.text = dialogue.messages[current_message].name
	text_box.text = dialogue.messages[current_message].text
	$MarginContainer/VBoxContainer.size_flags_horizontal = dialogue.messages[current_message].position * 4 
	current_message += 1


func _unhandled_input(_event: InputEvent) -> void:
	display_next_message()
	
