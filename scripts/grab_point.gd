class_name GrabPoint
extends Marker2D

@export var label: Label

func _init() -> void:
	add_to_group("GrabPoints")

func update_label() -> void:
	label.text = "grab (" + InputMap.get_action_description("interact") + ")"
