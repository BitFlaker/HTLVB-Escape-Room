extends Node2D

func _ready() -> void:
	if Globals.calledRoomBySelector != Globals.RoomCall.None:
		$CanvasLayer/BackButton.show()
		$CanvasLayer2/VarsAndDesign.queue_free()
		ZZInGameUi.onlyShowButtons()
	Globals.currentRoom = Globals.Rooms.NAWI
	$CanvasLayer/DialogBox/Content.text = "Klicke auf die Begriffe Instagram oder Youtube für mehr Infos. Schau dir dort alle Videos an und lese die Titel der Videos."
	$CanvasLayer/DialogBox.show()

func _on_instagramButton_released() -> void:
	OS.shell_open("https://www.instagram.com/nawi.htlvb/")

func _on_youtubeButton_released() -> void:
	OS.shell_open("https://www.youtube.com/channel/UCLA6kv7sN_6bCBSQbEwTv2Q/")

func _on_DialogOkButton_released() -> void:
	$CanvasLayer/DialogBox.hide()
	$CanvasLayer2/Sprite/instagramButton.show()
	$CanvasLayer2/Sprite/youtubeButton.show()

func _on_BackButton_pressed() -> void:
	Globals.returnToSelector()
