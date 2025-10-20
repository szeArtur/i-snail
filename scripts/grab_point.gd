class_name GrabPoint
extends Marker2D


@onready var label: Label = $Label
@onready var raycast: RayCast2D = $RayCast2D


func _ready() -> void:
	update(false)


func is_in_sight(target: Vector2) -> bool:
	raycast.target_position = target - position
	return not raycast.is_colliding()


func update(active := false) -> void:
	label.text = "grab (" + InputMap.get_action_description("interact") + ")"
	visible = active
