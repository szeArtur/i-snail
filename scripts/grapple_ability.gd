class_name GrappleAbility
extends Ability


@export var max_grab_range: float = 10000
@export var min_grab_range: float = 200
@export var pull_velocity: float = 1000

var grab_point_target: Node2D


func update(delta: float, input_direction: float = 0) -> void:
	get_closest_grab_point()
	if grab_point_target:
		if pull_and_collide(delta, grab_point_target.position):
			grab_point_target = null
	else:
		agent.move_and_stick(delta, input_direction)


func activate() -> void:
	grab_point_target = get_closest_grab_point()



func pull_and_collide(delta: float, target: Vector2) -> bool:
	agent.velocity = lerp(agent.velocity,(target - agent.position).normalized() * pull_velocity, 10 * delta)
	agent.rotation = lerp(agent.rotation, agent.velocity.rotated(PI/2).angle(), 4 * delta)
	
	agent.move_and_slide()	
	if (agent.get_slide_collision_count() > 0 or target.distance_to(agent.position) < 40):
		return true
	
	return false


func get_closest_grab_point() -> GrabPoint:
	var grab_points := agent.get_tree().get_nodes_in_group("GrabPoints")
	grab_points.sort_custom(get_closer_point)
	
	var closest_grab_point: GrabPoint = null
	
	for grab_point in grab_points:
		var point_distance = grab_point.position.distance_to(agent.position)
		var point_in_range = point_distance < max_grab_range and point_distance > min_grab_range
		
		if point_in_range and grab_point.is_in_sight(agent.position) and not closest_grab_point:
			closest_grab_point = grab_point
			grab_point.update(true)
		else:
			grab_point.update(false)
	
	return closest_grab_point


func get_closer_point(a: Node2D, b: Node2D) -> bool:
	return a.position.distance_to(agent.position) < b.position.distance_to(agent.position)
