class_name MovementController
extends Resource


var agent: Agent

@export var base_speed: float = 8000.0
@export var sticky_speed_multiplier: float = 0.7


func jump(force: float) -> void:
		agent.velocity.y = -force 

func fall(delta: float) -> void:
	agent.up_direction = Vector2.UP
	
	agent.rotation = lerp(agent.rotation, 0.0, delta)
	agent.velocity += agent.get_gravity() * delta
	agent.velocity.x *= 0.01 ** delta
	agent.move_and_slide()

	if agent.get_slide_collision_count() > 0:
		agent.is_falling = false

func move(delta: float, direction: float, stick: bool) -> void:
	if direction == 0:
		agent.sprite.play("idle")
	else:
		agent.sprite.scale.x = sign(direction) * abs(agent.sprite.scale.y)
		agent.sprite.play("move")
	
	#agent.floor_max_angle = 2.0 if stick else PI / 4
	
	var on_floor: bool = false
	
	agent.apply_floor_snap()
	if agent.is_on_floor():
		on_floor = true
	if agent.is_on_wall(): print("lesgoooo")
	
	if cos(agent.rotation) < - 0.2:
		on_floor = false
		agent.up_direction = Vector2.UP
	
	var target_rotation := 0.0
	if on_floor and agent.is_on_floor():
		if abs(agent.get_floor_angle()) < PI/4 or stick:
			agent.up_direction = agent.get_floor_normal()
			target_rotation = agent.get_floor_normal().angle() + (PI / 2)
		else:
			on_floor = false
	agent.rotation = lerp(agent.rotation, target_rotation, delta * 10)
	
	var speed = base_speed * (sticky_speed_multiplier if stick else 1.0)
	var target_velocity := (Vector2.RIGHT * direction * speed * delta).rotated(agent.rotation)
	if on_floor:
			agent.velocity = lerp(agent.velocity, target_velocity, delta * 10)
	else:
		agent.velocity += agent.get_gravity() * delta
	
	agent.velocity *= 0.9 ** delta
	agent.move_and_slide()
