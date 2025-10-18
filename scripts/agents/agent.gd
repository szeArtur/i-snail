class_name Agent
extends CharacterBody2D



@export var shell = Item.new()
@export var base_speed := 8000.0

@export_group("Connections")
@export var hitbox: Area2D
@export var viewbox: Area2D
@export var shell_sprite: Sprite2D
@export var sprite: AnimatedSprite2D
@export var move_sound: AudioStreamPlayer2D
@export var floor_detector: ShapeCast2D
@export var detatch_cooldown: Timer


var stick := true
var on_floor := false
var target_velocity_fw := 0.0


func _ready() -> void:
	reset()
	
	if hitbox:
		hitbox.body_entered.connect(_on_hitbox_entered)
		hitbox.area_entered.connect(_on_hitbox_entered)
		hitbox.body_exited.connect(_on_hitbox_exited)
		hitbox.area_exited.connect(_on_hitbox_exited)

	if viewbox:
		viewbox.body_entered.connect(_on_viewbox_entered)
		viewbox.area_entered.connect(_on_viewbox_entered)
		viewbox.body_exited.connect(_on_viewbox_exited)
		viewbox.area_exited.connect(_on_viewbox_exited)


func reset() -> void:
	velocity = Vector2.ZERO
	stick = false
	on_floor = false
	move_sound.playing = true
	move_sound.stream_paused = true
	if shell:
		shell_sprite.texture = shell.sprite


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
	
	# wall sticking behaviour/gravity
	if stick and floor_detector.is_colliding() and detatch_cooldown.is_stopped():
		up_direction = floor_detector.get_collision_normal(0)
		move_and_collide(up_direction * -100)
		apply_floor_snap()
		if is_on_floor():
			up_direction = get_floor_normal()
		velocity_up_component = Vector2.ZERO
	else:
		up_direction = Vector2.UP
		velocity_up_component += get_gravity() * delta
	
	# player input/modify velocity
	var inertia_influence := 0.0 if floor_detector.is_colliding() else 0.95
	if input_direction != 0 and sign(target_velocity_fw) != sign(input_direction):
		target_velocity_fw *= 2 * delta
	target_velocity_fw = lerp(target_velocity_fw, 100 * input_direction, 10 * delta)
	target_velocity_fw = lerp(target_velocity_fw, fw_velocity, inertia_influence)
	
	# apply velocity
	velocity_fw_component = fw_direction * target_velocity_fw
	velocity = velocity_up_component + velocity_fw_component
	velocity *= 0.2 ** delta # apply drag
	move_and_slide()
	
	# update visuals
	var target_rotation := fw_direction.angle() if is_on_floor() else 0.0
	rotation = lerp(rotation, target_rotation, 10 * delta)
	
	if fw_velocity == 0:
		sprite.play("idle")
	else:
		sprite.scale.x = sign(fw_velocity) * abs(sprite.scale.y)
		sprite.play("move")


func pull_and_collide(delta: float, target: Vector2) -> bool:
	velocity = lerp(velocity,(target - position).normalized() * 1000, 10 * delta)
	move_and_slide()
	
	rotation = lerp(rotation, velocity.rotated(PI/2).angle(), 4 * delta)
	
	if (get_slide_collision_count() > 0
	or target.distance_to(position) < 40):
		return true
	
	return false


func _on_hitbox_entered(_body: CollisionObject2D) -> void:
	pass
func _on_hitbox_exited(_body: CollisionObject2D) -> void:
	pass
func _on_viewbox_entered(_body: CollisionObject2D) -> void:
	pass
func _on_viewbox_exited(_body: CollisionObject2D) -> void:
	pass
	pass
