class_name Player
extends Agent

@export var movement_speed := 60
@export var inventory: Inventory
@export var wheel1: ShapeCast2D
@export var wheel2: ShapeCast2D

var falling := true



func _on_hitbox_entered(body: CollisionObject2D) -> void:
	if body is Collectable:
		inventory.add_item(body.item, body.amount)


func _physics_process(delta: float) -> void:
	var input_direction = Vector2.RIGHT * Input.get_axis("move_left", "move_right") * movement_speed
	
	if falling:
		velocity += get_gravity() * delta
		if move_and_slide():
			falling = false
	
	else:
		velocity = global_transform.basis_xform(input_direction)
		move_and_slide()
			
		if not wheel1.is_colliding():
			rotation += PI/4
		elif not wheel2.is_colliding():
			rotation -= PI/4
		elif wheel1.is_colliding() and wheel2.is_colliding():
			var new_slope_direction = wheel1.get_collision_point(0) - wheel2.get_collision_point(0)
			rotation = new_slope_direction.angle()
			
		move_and_collide(global_transform.basis_xform(Vector2.DOWN))
	
	if cos(rotation) < -0.2 :
		rotation = 0
		falling = true
	
