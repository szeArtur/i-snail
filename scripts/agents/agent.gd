class_name Agent
extends CharacterBody2D


@export var collision_shape: CollisionShape2D
@export var hitbox: Area2D
@export var hurtbox: Area2D
@export var viewbox: Area2D
@export var movement_controller: MovementController

var initial_position: Vector2


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

	if movement_controller:
		movement_controller.agent = self

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
