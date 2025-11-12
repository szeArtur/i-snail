class_name Enemy
extends Agent

@export var stopped := false
@export var facing_right := true
@export var looking_for_player: bool = true

var player: Player

@onready var view_ray: RayCast2D = $ViewRay
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _physics_process(delta: float) -> void:
	if not stopped:
		move_and_stick(delta, 1 if facing_right else -1)
	
	if is_player_in_sight() and looking_for_player:
		animation_player.play("spot_player")
		


func spot_player() -> void:
	EventBus.player_detected.emit()


func on_viewbox_entered(body: CollisionObject2D) -> void:
	if body is TurnArea:
		facing_right = not facing_right


func is_player_in_sight() -> bool:
	if not player:
		return false
	
	view_ray.target_position = player.global_position - global_position
	if view_ray.is_colliding():
		return false
	
	return true


func on_player_detection_entered(body: CollisionObject2D) -> void:
	if body is Player:
		player = body


func on_player_detection_exited(body: CollisionObject2D) -> void:
	if body is Player:
		player = null
