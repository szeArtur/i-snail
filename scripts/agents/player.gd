class_name Player
extends Agent


@onready var item_drop_position: Marker2D = $FlipOrigin/ItemDropPosition


func reset() -> void:
	super.reset()
	shell_collider_shape.disabled = true
	stick = false


func on_hitbox_entered(_body: CollisionObject2D) -> void:
	GameManager.push_state(GameManager.GameState.RELOADING)


func on_viewbox_entered(body: CollisionObject2D) -> void:
	if body is Shell:
		call_deferred("collect", body)


func collect(ref: Shell) -> void:
	shell_collider_shape.disabled = false
	if shell_collider.test_move(shell_collider.global_transform, Vector2.ZERO):
		shell_collider_shape.disabled = true
		return
	
	if not ref.is_collectable:
		return
	
	shell = ref
	shell.collect(self)


func _physics_process(delta: float) -> void:
	var input_direction := Input.get_axis("move_left", "move_right")
	
	if shell:
		shell.ability.update(delta, input_direction)
	else:
		move_and_stick(delta, input_direction)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and shell:
		shell.ability.activate()
	
	if event.is_action_pressed("drop_item"):
		drop_shell()
	
	if event.is_action_pressed("stick"):
		stick = true
	
	if event.is_action_released("stick"):
		stick = false


func drop_shell() -> void:
	if not shell:
		return
	
	shell.drop(velocity + Vector2.UP * 60)
	shell = null
	shell_collider_shape.disabled = true
