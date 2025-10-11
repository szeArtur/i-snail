class_name Agent
extends CharacterBody2D


@export var hitbox: Area2D
@export var hurtbox: Area2D
@export var viewbox: Area2D

@export var base_speed := 8000.0
@export var sticky_speed_multiplier := 0.7

var initial_position: Vector2
var movement_controller := MovementController.new(self)
var is_falling := true
var stick := false


func _ready() -> void:
	if hitbox:
		hitbox.body_entered.connect(_on_hitbox_entered)
		hitbox.area_entered.connect(_on_hitbox_entered)
		hitbox.body_exited.connect(_on_hitbox_exited)
		hitbox.area_exited.connect(_on_hitbox_exited)

	if hurtbox:
		hurtbox.body_entered.connect(_on_hurtbox_entered)
		hurtbox.area_entered.connect(_on_hurtbox_entered)
		hurtbox.body_exited.connect(_on_hurtbox_exited)
		hurtbox.area_exited.connect(_on_hurtbox_exited)

	if viewbox:
		viewbox.body_entered.connect(_on_viewbox_entered)
		viewbox.area_entered.connect(_on_viewbox_entered)
		viewbox.body_exited.connect(_on_viewbox_exited)
		viewbox.area_exited.connect(_on_viewbox_exited)

	initial_position = global_position


func reset() -> void:
	velocity = Vector2(0,0)
	global_position = initial_position


func _on_hitbox_entered(_body: CollisionObject2D) -> void:
	pass


func _on_hitbox_exited(_body: CollisionObject2D) -> void:
	pass


func _on_hurtbox_entered(_body: CollisionObject2D) -> void:
	pass


func _on_hurtbox_exited(_body: CollisionObject2D) -> void:
	pass


func _on_viewbox_entered(_body: CollisionObject2D) -> void:
	pass


func _on_viewbox_exited(_body: CollisionObject2D) -> void:
	pass


class MovementController:
	var agent: Agent
	
	func _init(parent: Agent) -> void:
		agent = parent
	func jump(force:float):
		agent.velocity.y = -force 
		#agent.is_falling=true
		
	func fall(delta: float) -> void:
		
		agent.rotation = lerp(agent.rotation, 0.0 , delta)
		agent.velocity += agent.get_gravity() * delta
		agent.move_and_slide()
		if agent.get_slide_collision_count() > 0:
			agent.is_falling = false
	
	func move(delta: float, direction: Vector2, stick := false) -> void:
	
		if agent.is_falling:
			fall(delta)
			return
		
		if stick:
			agent.apply_floor_snap()
			if not agent.is_on_floor() or cos(agent.rotation) < 0:
				agent.is_falling = true
				agent.up_direction = Vector2.UP
				return
		
			agent.up_direction = agent.get_floor_normal()
		
		var target_rotation := agent.get_floor_normal().angle() + (PI / 2) if agent.is_on_floor() else 0.0
		agent.rotation = lerp(agent.rotation, target_rotation, delta * 10)
		
		var speed = agent.base_speed
		if stick:
			speed *= agent.sticky_speed_multiplier
			agent.velocity = agent.global_transform.basis_xform(direction * speed * delta)
		else:
			agent.velocity.x = direction.x * speed * delta
			agent.velocity += agent.get_gravity() * delta
		agent.move_and_slide()
