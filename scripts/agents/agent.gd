@abstract class_name Agent
extends CharacterBody2D


@export var shell: Item
@export var base_speed := 8000.0

@export_group("Connections")
@export var hitbox: Area2D
@export var viewbox: Area2D
@export var shell_sprite: Sprite2D
@export var sprite: AnimatedSprite2D
@export var move_sound: AudioStreamPlayer2D
@export var floor_detector: ShapeCast2D
@export var detatch_cooldown: Timer
@export var shell_collider: AnimatableBody2D

var stick: bool
var target_velocity_fw := 0.0

func on_hitbox_entered(_body: CollisionObject2D) -> void: pass
func on_hitbox_exited(_body: CollisionObject2D) -> void: pass
func on_viewbox_entered(_body: CollisionObject2D) -> void: pass
func on_viewbox_exited(_body: CollisionObject2D) -> void: pass


func _ready() -> void:
	reset()
	
	if hitbox:
		hitbox.body_entered.connect(on_hitbox_entered)
		hitbox.area_entered.connect(on_hitbox_entered)
		hitbox.body_exited.connect(on_hitbox_exited)
		hitbox.area_exited.connect(on_hitbox_exited)

	if viewbox:
		viewbox.body_entered.connect(on_viewbox_entered)
		viewbox.area_entered.connect(on_viewbox_entered)
		viewbox.body_exited.connect(on_viewbox_exited)
		viewbox.area_exited.connect(on_viewbox_exited)


func reset() -> void:
	velocity = Vector2.ZERO
	stick = false
	move_sound.playing = true
	move_sound.stream_paused = true
	shell = null


func move_and_stick(delta: float, input_direction: float) -> void:
	# wall detection
	floor_max_angle = PI if stick else PI/4
	
	# overhang detection
	if sin(up_direction.angle()) > 0.4:
		detatch_cooldown.start()
	
	# split up velocity in up and forward component
	var fw_direction := up_direction.rotated(PI/2)
	var velocity_up_component := up_direction * velocity.dot(up_direction)
	var velocity_fw_component := fw_direction * velocity.dot(fw_direction)
	var fw_velocity = velocity_fw_component.dot(fw_direction) / fw_direction.length_squared()
	
	var on_floor = stick and floor_detector.is_colliding() and detatch_cooldown.is_stopped()
	
	# inertia/drag
	var inertia_influence: float 
	if floor_detector.is_colliding() and input_direction != 0:
		inertia_influence = 0.1
	elif floor_detector.is_colliding() and input_direction == 0:
		inertia_influence = 0.3
	elif not floor_detector.is_colliding() and input_direction != 0:
		inertia_influence = 0.6
	else:
		inertia_influence = 0.95
	
	# player input
	if input_direction != 0 and sign(target_velocity_fw) != sign(input_direction):
		target_velocity_fw *= 2 * delta
	target_velocity_fw = lerp(target_velocity_fw, 100 * input_direction, 10 * delta)
	target_velocity_fw = lerp(target_velocity_fw, fw_velocity, inertia_influence)
	
	
	
	# apply velocity
	velocity_fw_component = fw_direction * target_velocity_fw
	velocity_up_component = Vector2.ZERO if on_floor else velocity_up_component + get_gravity() * delta
	velocity = velocity_up_component + velocity_fw_component
	velocity *= 0.2 ** delta # apply drag
	
	if shell_collider.test_move(shell_collider.global_transform, velocity * delta):
		velocity = Vector2.ZERO
	else:
		move_and_slide()
	
	# rigid body collision
	# adapted from https://kidscancode.org/godot_recipes/4.x/physics/character_vs_rigid/
	if not stick:
		for i in get_slide_collision_count():
			var collision := get_slide_collision(i)
			var collider = collision.get_collider()
			if collider is RigidBody2D:
				collider.apply_central_impulse(-collision.get_normal() * 10)
	
	# wall sticking behaviour (up direction)
	if on_floor:
		if is_on_floor():
			up_direction = get_floor_normal()
		else:
			up_direction = floor_detector.get_collision_normal(0)
		move_and_collide(up_direction * -100)
		apply_floor_snap()
	else:
		up_direction = Vector2.UP
	
	# update visuals
	var target_rotation := fw_direction.angle() if is_on_floor() else 0.0
	rotation = lerp(rotation, target_rotation, 10 * delta)
	
	if fw_velocity == 0:
		sprite.play("idle")
	else:
		sprite.scale.x = sign(fw_velocity) * abs(sprite.scale.y)
		sprite.play("move")
