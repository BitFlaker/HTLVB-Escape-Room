extends Panel

var time_left := 10

func _on_Timer_timeout() -> void:
	time_left -= 1
	if time_left == 0: 
		$Timer.stop()
		get_parent().hide()
		ZZInGameUi.showAllPrevVisibleTSButtons()
		time_left = 10
	$BubbleContainer/TimeLeft.text = str(time_left)

func start_countdown() -> void:
	$Timer.start(1)

func _on_CopyButton_pressed() -> void:
	OS.set_clipboard($SignMessage.text)
