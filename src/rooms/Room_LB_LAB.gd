extends Node2D

var hasVisitedLearningApps := false
var canClick := true

func _ready() -> void:
	Globals.currentRoom = Globals.Rooms.LAB

func _on_StampZoom_released() -> void:
	if canClick: 
		$ColorRect.rect_position = $LabBackground/StampZoom.get_global_transform().get_origin()
		$ColorRect.rect_size = ($LabBackground/StampZoom.scale * Vector2(800, 600))*Vector2(0.656,0.656)
		$Camera2D.zoom_in(($ColorRect.rect_position + ($ColorRect.rect_size / Vector2(2,2))) - $Camera2D.get_camera_position())

func _on_BackButton_released() -> void:
	if canClick: get_tree().change_scene("res://scenes/rooms/Laboratory/Building_Laboratory.tscn")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed == false and $Camera2D.current_zoom == Vector2($Camera2D.zoom_factor,$Camera2D.zoom_factor):
		var evLocal = make_input_local(event)
		
		if !$ColorRect.get_rect().has_point(evLocal.position):
			zoomReset()

func zoomReset() -> void:
	if canClick: $Camera2D.zoom_out(Vector2(512,300))

func _on_CleanLabPhone_released() -> void:
	if canClick: 
		OS.shell_open("https://learningapps.org/watch?v=pruwspx7c20")
		hasVisitedLearningApps = true

func _on_CodeNote_released() -> void:
	if canClick: 
		if hasVisitedLearningApps:
			var divNum = get_tree().get_root().get_node("Globals").takenLabDivNum
			$CanvasLayer/DialogBox/Important.hide()
			$CanvasLayer/DialogBox/Content.text = str("Für den Code wird eine Ziffer benötigt.\nDas Rätsel hat dir aber eine\nmehrstellige Zahl ausgegeben.\nScheinbar hatte das Rätsel einen\nkleinen Programmierfehler.\nFinde die richtige Ziffer für den Code,\nindem du durch ", divNum, " teilst.")
			$CanvasLayer/DialogBox.show()
			canClick = false
		else:
			$CanvasLayer/DialogBox/Important.show()
			$CanvasLayer/DialogBox/Content.text = "Hilft zuerst beim\nAufräumen der Labore!"
			$CanvasLayer/DialogBox.show()
			canClick = false

func _on_DialogOkButton_released() -> void:
	$CanvasLayer/DialogBox.hide()
	canClick = true
