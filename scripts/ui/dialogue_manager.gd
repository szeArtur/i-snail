extends Control

@export var dialogue: Dialogue
@export var name_box: Label 
@export var text_box: Label
@export var dialogue_box: Container

@export var sprite_left: Sprite2D 

@export var sprite_right: Sprite2D 

var current_message := 0


func _ready() -> void:
	say(dialogue.messages[current_message])


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if current_message < dialogue.messages.size() -1:
			current_message += 1
			say(dialogue.messages[current_message])


func say(message: DialogueMessage) -> void:
	name_box.text = message.character.name
	text_box.text = message.text
	
	if message.flipped:
		dialogue_box.size_flags_horizontal = Control.SIZE_SHRINK_END
		name_box.size_flags_horizontal = Control.SIZE_SHRINK_END
		sprite_right.texture = message.character.sprite
		$SpriteRight/AnimationPlayer.play("speaking")
		$SpriteLeft/AnimationPlayer.play("resting")
	
	else:
		dialogue_box.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
		name_box.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
		sprite_left.texture = message.character.sprite
		$SpriteLeft/AnimationPlayer.play("speaking")
		$SpriteRight/AnimationPlayer.play("resting")
		
