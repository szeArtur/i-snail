class_name Player
extends Agent


@export var inventory: Inventory
@export var wheel1: ShapeCast2D
@export var wheel2: ShapeCast2D


func _on_hitbox_entered(body: CollisionObject2D) -> void:
	if body is Collectable:
		inventory.add_item(body.item, body.amount)


func _physics_process(_delta: float) -> void:
	velocity = global_transform.basis_xform(Vector2.RIGHT * Input.get_axis("move_left", "move_right")) * 60
	move_and_slide()
	
	var new_slope_direction
	if not wheel1.is_colliding():
		rotation += PI/4
	elif not wheel2.is_colliding():
		rotation -= PI/4
	else:
		new_slope_direction = wheel1.get_collision_point(0) - wheel2.get_collision_point(0)
		rotation = new_slope_direction.angle()
	
	#var wheel1_position := wheel1.get_collision_point(0) if wheel1.is_colliding() else (wheel1.global_position + wheel1.target_position)
	#var wheel2_position := wheel2.get_collision_point(0) if wheel2.is_colliding() else (wheel2.global_position + wheel2.target_position) 
	#var new_slope_direction := wheel1_position - wheel2_position
	#rotation = new_slope_direction.angle()
	
	move_and_collide(global_transform.basis_xform(Vector2.DOWN))
