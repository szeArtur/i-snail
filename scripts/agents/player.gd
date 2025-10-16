class_name Player
extends Agent


@export_category("Gappl")
@export var min_grab_range := 60
@export var max_grab_range := 300

@export_category("Pulling")
@export var pull_speed_max: float
@export var pull_acceleration: float

@onready var item_drop_position_forward = $Sprite/ItemDropPositionForward
@onready var item_drop_position_backward = $Sprite/ItemDropPositionBackward

var pulling := false
var pull_target: Node2D
var ability = Ability.new()


func reset() -> void:
	super.reset()
	pulling = false
	ability.type = Ability.AbilityType.NONE


func _on_hitbox_entered(_body: CollisionObject2D) -> void:
	GameManager.push_state(GameManager.GameState.RELOADING)


func _on_viewbox_entered(body: CollisionObject2D) -> void:
	if body is Collectable:
		body.pickup()
		shell = body.item
		shell_sprite.texture = shell.sprite
		ability.type = shell.ability.type
	if body is ShellDropArea:
		drop_shell(false)


func _physics_process(delta: float) -> void:
	var movement_direction := Input.get_axis("move_left", "move_right")
	
	#if pulling:
		#velocity += (pull_target.position - position).normalized() * pull_acceleration * delta
		#move_and_slide()
		#if position.distance_to(pull_target.position) < 40:
			#pulling = false
		#return
	
	move(delta, movement_direction)
	get_closest_grab_point()
	
	if stick:
		return
	
	for i in get_slide_collision_count():
		var collidng_body = get_slide_collision(i)
		if collidng_body.get_collider() is RigidBody2D:
			collidng_body.get_collider().apply_central_impulse(-collidng_body.get_normal()*4)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		match ability.type:
			Ability.AbilityType.GRAPPLE:
				pull_to_nearest_point()
	
	if event.is_action_pressed("drop_item"):
		drop_shell()
	
	if event.is_action_pressed("stick"):
		stick = true
	
	if event.is_action_released("stick"):
		stick = false


func pull_to_nearest_point() -> void:
	if not get_closest_grab_point():
		return
	
	pull_target = get_closest_grab_point()
	pulling = true

func get_closest_grab_point() -> GrabPoint:
	if ability.type != Ability.AbilityType.GRAPPLE:
		return
	
	var grab_points := get_tree().get_nodes_in_group("GrabPoints")
	grab_points.sort_custom(get_closer_point)
	
	var closest_grab_point: GrabPoint = null
	
	for grab_point in grab_points:
		var point_distance = grab_point.position.distance_to(position)
		var point_in_range = point_distance < max_grab_range and point_distance > min_grab_range
		if point_in_range and closest_grab_point == null:
			closest_grab_point = grab_point
			grab_point.label.show()
			grab_point.update_label()
		else:
			grab_point.label.hide()
	
	return closest_grab_point


func get_closer_point(a: Node2D, b: Node2D) -> bool:
	if a.position.distance_to(position) < b.position.distance_to(position):
		return true
	return false

func drop_shell(forward := true) -> void:
	if not shell:
		return
	
	var at : Vector2
	if forward:
		at = item_drop_position_forward.global_position
	else:
		at = item_drop_position_backward.global_position
	
	var toward = velocity + (at - global_position) * 3
	EventBus.drop_item.emit(shell, at, toward)
	shell = null
	shell_sprite.texture = null
