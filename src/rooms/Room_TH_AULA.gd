extends Node2D

func _ready() -> void:
	if Globals.calledRoomBySelector != Globals.RoomCall.None: 
		$CanvasLayer3/BackButton.show()
		$CanvasLayer2/VarsAndDesign.queue_free()
		ZZInGameUi.onlyShowButtons()
	Globals.currentRoom = Globals.Rooms.AULA
	ZZInGameUi.hideAllVisibleTSButtons()
	$CanvasLayer3/DialogBox/DialogOkButton.show()

func _on_Monitor_released() -> void:
	$AnimationPlayer.play("GetInScreen")
	OS.shell_open("https://learningapps.org/watch?v=p3rfhwhi220")

func zoomToMonitor() -> void:
	var pos = $CanvasLayer2/Monitor.get_global_transform().get_origin()
	var size = $CanvasLayer2/Monitor.get_global_transform().get_scale() * Vector2(800,600)
	$Camera2D.zoom_in((pos + (size / Vector2(2,2))) - $Camera2D.get_camera_position())

func zoomTotallyOut() -> void:
	$Camera2D.zoom_out(Vector2(512,300))

func _on_DialogOkButton_released() -> void:
	ZZInGameUi.showAllPrevVisibleTSButtons()
	$CanvasLayer3/DialogBox.hide()
	$CanvasLayer2/Monitor.show()

func _on_BackButton_pressed() -> void:
	Globals.returnToSelector()
