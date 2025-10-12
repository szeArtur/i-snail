class_name Enemy
extends Agent
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_2d: RayCast2D = $AnimatedSprite2D/RayCast2D


@export var jumpforce := 10.0
@export var start_links:= true
var player_senn_prog =0
var movement_direction


func _ready() -> void:
	super._ready()
	if start_links:
		movement_direction = -1
	else:
		movement_direction = 1

func _physics_process(delta: float) -> void:
	if ray_cast_2d.is_colliding():
		#line_2d.
		if ray_cast_2d.get_collider() is Player:
			player_senn_prog=1
	if player_senn_prog != 1:
		movement_controller.move(delta, movement_direction, true)
	else: 
		animated_sprite_2d.play("button")
	
		
func _on_hitbox_entered(body: CollisionObject2D) -> void:
	if body is TurnaroundEnemy:
		movement_direction *= -1


func _on_visionbox_body_entered(_body: Node2D) -> void:
	if player_senn_prog == 0:
		player_senn_prog=1
