extends Light2D

var isFlashlightOn := false
var isMovingPhone := false
var xDiff := 0.0
var yDiff := 0.0
var hasShown := false

func _process(_delta: float) -> void:
	if isMovingPhone:
		var pos = get_viewport().get_mouse_position()
		position.x = pos.x - xDiff
		position.y = pos.y - yDiff

func _on_TouchScreenButton_pressed() -> void:
		var clickPos = get_viewport().get_mouse_position()
		var curPos = position
		xDiff = clickPos.x - curPos.x
		yDiff = clickPos.y - curPos.y
		isMovingPhone = true

func _on_TouchScreenButton_released() -> void:
	isMovingPhone = false

func _on_ToggleFlashlight_pressed() -> void:
	if !isFlashlightOn:
		isFlashlightOn = !isFlashlightOn
		enabled = isFlashlightOn
		if !hasShown:
			hasShown = true
			var hintScreen = get_tree().get_root().get_node("RoomCAD/CanvasLayer/HintForHintButton")
			hintScreen.show()
			hintScreen.get_node("AnimationPlayer2").play("appear")
