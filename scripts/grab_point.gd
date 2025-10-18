class_name GrabPoint
extends Marker2D


@export var label: Label


func _ready() -> void:
	update_label()


func update_label() -> void:
	label.text = "grab (" + InputMap.get_action_description("interact") + ")"
