class_name Player
extends Agent


@export_category("Gappl")
@export var min_grab_range := 60
@export var max_grab_range := 300
@export var jumpforce := 10.0

@export_category("Pulling")
@export var pull_speed_max: float
@export var pull_acceleration: float

var pulling := false
var pull_target: Vector2



func _on_hitbox_entered(body: CollisionObject2D) -> void:
	if body is Collectable:
		shell = body.item
		shell_sprite.texture = shell.sprite
		body.pickup()

func jumppad(force):		
	movement_controller.jump(force/10)


func _process(_delta: float) -> void:
	get_closest_grab_point() 


func _physics_process(delta: float) -> void:
	var movement_direction := Input.get_axis("move_left", "move_right")
	
	if pulling:
		velocity += (pull_target - position).normalized() * pull_acceleration * delta
		move_and_slide()
		if position.distance_to(pull_target) < 40:
			pulling = false
		return
	
	movement_controller.move(delta, movement_direction, stick)
	
	if not stick:
		for i in get_slide_collision_count():
			var collidng_body = get_slide_collision(i)
			if collidng_body.get_collider() is RigidBody2D:
				collidng_body.get_collider().apply_central_impulse(-collidng_body.get_normal()*4)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
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
	
	pull_target = get_closest_grab_point().position
	pulling = true

func get_closest_grab_point() -> GrabPoint:
	var grab_points := get_tree().get_nodes_in_group("GrabPoints")
	grab_points.sort_custom(get_closer_point)
	
	var closest_grab_point: GrabPoint = null
	
	for grab_point in grab_points:
		var point_outside_min_range = grab_point.position.distance_to(position) < max_grab_range
		var point_inside_max_range = grab_point.position.distance_to(position) > min_grab_range
		if point_outside_min_range and point_inside_max_range and closest_grab_point == null:
			closest_grab_point = grab_point
			grab_point.label.show()
		else:
			grab_point.label.hide()
	
	return closest_grab_point


func get_closer_point(a: Node2D, b: Node2D) -> bool:
	if a.position.distance_to(position) < b.position.distance_to(position):
		return true
	return false

func drop_shell() -> void:
	if not shell:
		return
	
	var at = position + global_transform.basis_xform(Vector2(30, -30))
	var toward = velocity + global_transform.basis_xform(Vector2(200, -300))
	EventBus.drop_item.emit(shell, at, toward)
	shell = null
	shell_sprite.texture = null
