class_name Camera
extends Camera2D


@export var target: Node2D
@export_range(0.0, 1.0) var stiffness: float = 1


#func _physics_process(_delta: float) -> void:
	#var target_position = target.position if target else Vector2.ZERO
	#position = position.lerp(target_position, stiffness**2)
#
#
func reset() -> void:
	pass
	#position = target.position if target else Vector2(-300, 150)
