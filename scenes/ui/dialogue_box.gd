class_name DialogueBox
extends Node

enum HorizontalPosition {
	LEFT,
	MIDDLE,
	RIGHT,
}


@export var container: VBoxContainer
@export var text_box: Label
@export var name_box: Label


var horizontal_position: HorizontalPosition: set = set_horizontal_position


func set_horizontal_position(input) -> void:
	horizontal_position = input
	container.size_flags_horizontal = input * 4
	name_box.size_flags_horizontal = input * 4
