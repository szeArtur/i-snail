class_name Agent
extends CharacterBody2D



@export var shell: Item
@export var hitbox: Area2D
@export var hurtbox: Area2D
@export var shell_sprite: Sprite2D
@export var sprite: AnimatedSprite2D
@export var move_sound: AudioStreamPlayer2D
@export var floor_detector: ShapeCast2D
@export var falling_cooldown: Timer

@export_group("Stats")
@export var base_speed := 8000.0


var stick := true
var on_floor := false


func _ready() -> void:
	
	move_sound.playing = true
	move_sound.stream_paused = true
	if shell:
		shell_sprite.texture = shell.sprite
	
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


func reset() -> void:
	velocity = Vector2.ZERO
	shell = null
	shell_sprite.texture = null
	stick = false
	on_floor = false


func move(delta: float, direction: float) -> void:
	if direction == 0:
		sprite.play("idle")
	else:
		sprite.scale.x = sign(direction) * abs(sprite.scale.y)
		sprite.play("move")
	
	floor_max_angle = PI if stick else PI/4
	
	if sin(up_direction.angle()) > 0.4:
		falling_cooldown.start()
	
	if stick and floor_detector.is_colliding() and falling_cooldown.is_stopped():
		up_direction = floor_detector.get_collision_normal(0)
		velocity = up_direction.rotated(PI/2) * direction * base_speed * delta
		move_and_collide(up_direction * -100)
		apply_floor_snap()
		up_direction = get_floor_normal()
	else:
		velocity += get_gravity() * delta
		velocity.x = direction * base_speed * delta
		up_direction = Vector2.UP
	
	move_and_slide()
	
	var target_rotation := get_floor_normal().rotated(PI/2).angle() if is_on_floor() else 0.0
	rotation = lerp(rotation, target_rotation, 10 * delta)



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
