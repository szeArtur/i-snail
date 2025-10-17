extends Control

@export var dialogue: Dialogue

@export var name_box: Label 
@export var text_box: Label 

var current_message := 0


func _ready() -> void:
	display_next_message(current_message)


func display_next_message(index: int) -> void:
	if index >= dialogue.messages.size():
		return
	
	name_box.text = dialogue.messages[index].name
	text_box.text = dialogue.messages[index].text
	$MarginContainer.horizontal_position = dialogue.messages[index].position
	current_message = index + 1


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		display_next_message(current_message)
	
