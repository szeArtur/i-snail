class_name Player
extends Agent


@export var movement_speed := 60
@export var shell: Item
@export var shell_sprite: Sprite2D
@export var wheel1: ShapeCast2D
@export var wheel2: ShapeCast2D

var falling := true



func _on_hitbox_entered(body: CollisionObject2D) -> void:
	if body is Collectable:
		shell = body.item
		shell_sprite.texture = shell.sprite
		body.pickup()


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

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("drop_item"):
		drop_shell()


func drop_shell() -> void:
	if not shell:
		return
	
	var at = position + global_transform.basis_xform(Vector2(20, -20))
	var toward = velocity + global_transform.basis_xform(Vector2(100, -200))
	EventBus.drop_item.emit(shell, at, toward)
	shell = null
	shell_sprite.texture = null
