class_name Player
extends Agent


@export var shell: Item
@export var shell_sprite: Sprite2D

@export_category("Gappl")
@export var min_grab_range := 60
@export var max_grab_range := 300


func _ready() -> void:
	super._ready()
	movement_controller = MovementController.new(self)



func _on_hitbox_entered(body: CollisionObject2D) -> void:
	if body is Collectable:
		shell = body.item
		shell_sprite.texture = shell.sprite
		body.pickup()

func _process(_delta: float) -> void:
	var closest_grab_point := get_closest_grab_point() 
	if closest_grab_point:
		closest_grab_point.label.show()


func _physics_process(delta: float) -> void:
	var movement_direction = Vector2.RIGHT * Input.get_axis("move_left", "move_right")
	
	movement_controller._move(delta, movement_direction, stick)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("drop_item"):
		drop_shell()
	if event.is_action_pressed("stick"):
		floor_max_angle = TAU
		stick = true
	if event.is_action_released("stick"):
		floor_max_angle = PI / 4
		up_direction = Vector2.UP
		stick = false
	if event.is_action_pressed("interact"):
		pull_to_point()


func pull_to_point() -> void:
	pass

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
	
	var at = position + global_transform.basis_xform(Vector2(20, -20))
	var toward = velocity + global_transform.basis_xform(Vector2(100, -200))
	EventBus.drop_item.emit(shell, at, toward)
	shell = null
	shell_sprite.texture = null
