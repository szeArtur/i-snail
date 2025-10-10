class_name Player
extends Agent


@export var inventory: Inventory


func _on_hitbox_entered(body: CollisionObject2D) -> void:
	if body is Collectable:
		inventory.add_item(body.item, body.amount)


func _physics_process(delta: float) -> void:
	var input_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	movement_controller.move_and_slide_toward(input_direction, delta)
