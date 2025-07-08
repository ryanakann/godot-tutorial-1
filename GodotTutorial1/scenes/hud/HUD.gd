extends CanvasLayer

signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	await $MessageTimer.timeout

	show_message("Dodge the Creeps!")
	await $MessageTimer.timeout
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = "%d" % score


func _on_message_timer_timeout():
	$Message.hide()

func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()