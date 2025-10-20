class_name Player
extends Agent


@onready var item_drop_position_forward = $Sprite/ItemDropPositionForward
@onready var item_drop_position_backward = $Sprite/ItemDropPositionBackward


func reset() -> void:
	super.reset()
	shell = null
	$ShellCollider/Shell.disabled = true


func on_hitbox_entered(_body: CollisionObject2D) -> void:
	GameManager.push_state(GameManager.GameState.RELOADING)


func on_viewbox_entered(body: CollisionObject2D) -> void:
	if body is Collectable:
		body.pickup()
		call_deferred("collect", body.item)


func collect(item: Item) -> void:
		shell = item
		shell_sprite.texture = shell.sprite
		shell.ability.agent = self
		$ShellCollider/Shell.disabled = false


func _physics_process(delta: float) -> void:
	var input_direction := Input.get_axis("move_left", "move_right")
	
	if shell:
		shell.ability.update(delta, input_direction)
	else:
		move_and_stick(delta, input_direction)
	
	if not stick:
		for i in get_slide_collision_count():
			var collidng_body = get_slide_collision(i)
			if collidng_body.get_collider() is RigidBody2D:
				collidng_body.get_collider().apply_central_impulse(-collidng_body.get_normal()*4)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and shell:
		shell.ability.activate()
	
	if event.is_action_pressed("drop_item"):
		drop_shell()
	
	if event.is_action_pressed("stick"):
		stick = true
	
	if event.is_action_released("stick"):
		stick = false


func drop_shell(forward := true) -> void:
	if not shell:
		return
	
	$ShellCollider/Shell.disabled = true
	var at : Vector2
	if forward:
		at = item_drop_position_forward.global_position
	else:
		at = item_drop_position_backward.global_position
	
	var toward = velocity + (at - global_position) * 3
	EventBus.drop_item.emit(shell, at, toward)
	shell = null
	shell_sprite.texture = null
