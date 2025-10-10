class_name Enemy
extends Agent


var target: Node2D


func _physics_process(delta: float) -> void:
	if target:
		movement_controller.move_and_slide_toward(target.position - position, delta)


func _on_viewbox_entered(body: CollisionObject2D) -> void:
	if body is Player:
		target = body


func _on_viewbox_exited(body: CollisionObject2D) -> void:
	if body is Player:
		target = null
