extends Node2D

var _globals

func _ready() -> void:
	Globals.currentRoom = Globals.Rooms.AULA
	ZZInGameUi.hideAllVisibleTSButtons()
	$CanvasLayer3/DialogBox/DialogOkButton.show()


func _on_Monitor_released() -> void:
	_globals = get_tree().get_root().get_node("Globals")
	$AnimationPlayer.play("GetInScreen")
	OS.shell_open("https://learningapps.org/watch?v=p3rfhwhi220")

func showPage() -> void:
	pass # if it opens in new tab here, it gets recognized as Pop-up.... Has to be embedded
#	_globals.showWebPage("", "https://learningapps.org/watch?v=p3rfhwhi220")

func zoomToMonitor() -> void:
	var pos = $CanvasLayer2/Monitor.get_global_transform().get_origin()
	var size = $CanvasLayer2/Monitor.get_global_transform().get_scale() * Vector2(800,600)
	$Camera2D.zoom_in((pos + (size / Vector2(2,2))) - $Camera2D.get_camera_position())

func zoomTotallyOut() -> void:
	$Camera2D.zoom_out(Vector2(512,300))

func _on_DialogOkButton_released() -> void:
	ZZInGameUi.showAllPrevVisibleTSButtons()
	$CanvasLayer3/DialogBox.hide()
