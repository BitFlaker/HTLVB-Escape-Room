extends Node2D

var isDragging := false
var startPos := 0.0
var startDiff := 0.0
var startedVideo := false
var globals

func _ready() -> void:
	globals = get_tree().get_root().get_node("Globals")
	startPos = $CanvasLayer2/ScreenContent.position.x
	Globals.currentRoom = Globals.Rooms.GYM
	ZZInGameUi.hideAllVisibleTSButtons()
	$CanvasLayer/DialogBox/DialogOkButton.show()

func _on_TouchScreenButton1_released() -> void:
	$CanvasLayer2/Sprite.hide()
	$CanvasLayer2/onScreenLook.show()
	$CanvasLayer2/ScreenDrag.show()
	$CanvasLayer2/ScreenContent.show()
	$CanvasLayer2/PhoneTouches.hide()

func _process(_delta: float) -> void:
	if isDragging:
		var posX = get_global_mouse_position().x
		if (posX - startDiff) < startPos:
			$CanvasLayer2/ScreenContent.position.x = posX - startDiff
	if startedVideo && !globals.idExists("GymHTLWarriorVideo"):
		startedVideo = false
		$CanvasLayer2/ScreenContent.position.x = startPos
		$CanvasLayer2/ScreenContent.show()
		$CanvasLayer2/ScreenDrag.show()

func _on_ScreenDrag_pressed() -> void:
	startDiff = get_global_mouse_position().x - startPos
	isDragging = true

func _on_ScreenDrag_released() -> void:
	isDragging = false
	if $CanvasLayer2/ScreenContent.position.x - startPos > -360:
		$CanvasLayer2/ScreenContent.position.x = startPos
	else:
		get_tree().get_root().get_node("Globals").showVideo("Videos/HTLWarrior.webm", 212, 135, 687, 339, "true", "true", "GymHTLWarriorVideo", "webm")
		startedVideo = true
		$CanvasLayer2/ScreenContent.hide()
		$CanvasLayer2/ScreenDrag.hide()

func _on_DialogOkButton_released() -> void:
	$CanvasLayer/DialogBox.hide()
	ZZInGameUi.showAllPrevVisibleTSButtons()
