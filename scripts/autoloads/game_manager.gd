extends Node


signal state_changed(state_new)

enum GameState {
	INITIALIZING,
	INTRO,
	MAIN_MENU,
	PLAYING,
	PAUSED,
	LOADING,
	SAVING,
	CREATING_NEW_GAME,
	OPTIONS,
	RELOADING,
	CREDITS,
}

var state_stack: Array[GameState] = [GameState.INITIALIZING]


func change_state(state_new: GameState) -> void:
	if state_new == state_stack[-1]: return
	
	state_stack.clear()
	state_stack.append(state_new)
	print(GameState.keys()[state_new])
	state_changed.emit(state_new)


func push_state(state_new: GameState) -> void:
	if state_new == state_stack[-1]: return
	
	state_stack.append(state_new)
	print(GameState.keys()[state_stack[-1]])
	state_changed.emit(state_new)


func pop_state() -> void:
	if state_stack.size() == 0: return
	
	state_stack.pop_back()
	print(GameState.keys()[state_stack[-1]])
	state_changed.emit(state_stack[-1])


func _input(event):
	if event.is_action_pressed(&"ui_cancel"):
		match state_stack[-1]:
			GameState.PAUSED, GameState.OPTIONS:
				pop_state()
			GameState.PLAYING:
				push_state(GameState.PAUSED)


func quit_game():
	get_tree().quit()
