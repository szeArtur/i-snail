extends Node2D


func _ready() -> void:
	var scroll = $AnimationPlayer
	var credittheme = $Credits
	
	scroll.play("Scroll")
	credittheme.play()
	$CreditText/AnimatedSprite2D.play("move")
	$AnimatedSprite2D.play("move")


func return_to_menu() -> void:
	GameManager.change_state(GameManager.GameState.MAIN_MENU)
