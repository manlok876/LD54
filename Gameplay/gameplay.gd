extends Control

var start_flag : bool = false

func _ready():
	pause_gameplay()
	%GameText.fill_from_text(Game.game_text)
	start_countdown()
	return


func _process(_delta):
	pass

func _exit_tree():
	resume_gameplay()

# Handling pause

func pause_gameplay():
	get_tree().paused = true
	return

func resume_gameplay():
	get_tree().paused = false
	return

# Pause menu

func _unhandled_key_input(event):
	var key_event = event as InputEventKey
	if key_event.is_pressed() and key_event.keycode == KEY_ESCAPE:
		toggle_pause_menu()
	return

func toggle_pause_menu():
	if is_pause_menu_open():
		close_pause_menu()
	else:
		open_pause_menu()

func is_pause_menu_open() -> bool:
	return %PauseMenu.visible

func _on_pause_menu_resume_requested():
	close_pause_menu()
	return

func open_pause_menu():
	pause_gameplay()
	stop_countdown()
	%PauseMenu.visible = true
	return

func close_pause_menu():
	%PauseMenu.visible = false
	start_countdown()
	return

# Countdown

func start_countdown():
	%CountdownTimer.start()
	%CountdownUI.visible = true
	return

func stop_countdown():
	%CountdownUI.visible = false
	%CountdownTimer.stop()
	return

func _on_countdown_timer_timeout():
	%CountdownUI.visible = false
	resume_gameplay()
	if !start_flag:
		start_flag = true
		%GameText.start_text()
	return

func _on_countdown_timer_tick(seconds_left):
	%CountdownLabel.text = str(seconds_left)
	return
