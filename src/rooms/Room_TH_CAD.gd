extends Node2D

var collectedMap = false
var allowedToPress := true
var lightSwitchedOn := false

onready var varsAndDesign = get_node("CanvasLayer/VarsAndDesign")
onready var map = get_node("Map")

func _ready() -> void:
	ZZInGameUi.start()
	Globals.currentRoom = Globals.Rooms.CAD

func _on_ClickedLinkToExtern_released() -> void:
	if CanPress(): OS.shell_open("https://cad.onshape.com/documents/b7bee55d49d1004a6078f4cd/w/3c5340936c9c486874989431/e/70a9d762c3b9315d1bae7474")

func _on_MapCollection_released() -> void:
	if CanPress():
		collectedMap = true
		$CAD/MapCollection.queue_free()
		$CAD/EmptyCard.show()

func _on_ExitCADRoom_released() -> void:
	if CanPress():
		if collectedMap == true:
			$AnimationPlayer.play("LeaveCAD")
		else:
			$CanvasLayer/DialogBox/Content.text = "Du hast etwas Wichtiges vergessen (Lageplan). Schau dich noch etwas um."
			$CanvasLayer/DialogBox.show()

func _on_RoomSelect_AULA_released() -> void:
	if $CanvasLayer/BackgroundUnfocus.color != Color(0,0,0,0.48): get_node("Map")._on_RoomSelect_TH_AULA_released()

func _on_RoomSelect_CLASS_released() -> void:
	if $CanvasLayer/BackgroundUnfocus.color != Color(0,0,0,0.48): get_node("Map")._on_RoomSelect_TH_CLASS_released()

func _on_RoomSelect_MAP_released() -> void:
	pass

func _on_RoomSelect_MAP_pressed() -> void:
	varsAndDesign._on_OpenMapButton_pressed()

func CanPress() -> bool:
	var canPress = true
	
	if Rect2($FlashlightPhoneLayer/Light2D/PhoneImg/PhoneRect.get_global_rect().position,$FlashlightPhoneLayer/Light2D/PhoneImg/PhoneRect.get_rect().size).has_point(get_global_mouse_position()):
		canPress = false
	if lightSwitchedOn and canPress: return true
	elif !Rect2($FlashlightPhoneLayer/Light2D/FlashlightRect.get_global_rect().position,$FlashlightPhoneLayer/Light2D/FlashlightRect.get_rect().size).has_point(get_global_mouse_position()):
		canPress = false
	return canPress

#func _input(event: InputEvent) -> void:
#	if event is InputEventMouseButton and event.button_index == 1 and event.pressed == false and $Camera2D.current_zoom == Vector2($Camera2D.zoom_factor,$Camera2D.zoom_factor):
#		var evLocal = make_input_local(event)
#		if !Rect2($CanvasLayer/ColorRect.get_global_rect().position,$CanvasLayer/ColorRect.get_rect().size).has_point(evLocal.position):
#			$Camera2D.zoom_out(Vector2(512, 300))

func _on_CarTopDown_pressed() -> void:
	$CanvasLayer/BackgroundUnfocus.color = Color(0,0,0,0.48)
	$CanvasLayer/Control/CarTopDownImage.show()

func _on_CarBoard_pressed() -> void:
	$CanvasLayer/BackgroundUnfocus.color = Color(0,0,0,0.48)	
	$CanvasLayer/Control/CarBoardImage.show()

func _on_CarTopDown_released() -> void:
	$CanvasLayer/BackgroundUnfocus.color = Color(0,0,0,0)
	$CanvasLayer/Control/CarTopDownImage.hide()

func _on_CarBoard_released() -> void:
	$CanvasLayer/BackgroundUnfocus.color = Color(0,0,0,0)
	$CanvasLayer/Control/CarBoardImage.hide()

func _on_BackButton_released() -> void:
	$AnimationPlayer.play("GoBackCAD")

func _on_BackButtonFromMoreInfos_released() -> void:
	Globals.removeElement("HOLOLENS_CAD")
	$CanvasLayer/MoreInfosContent.hide()
	
	if Globals.openVideos.size() > 0:
		for vid in Globals.openVideos:
			Globals.removeElement(vid)
		Globals.openVideos.clear()

func _on_MoreInfos_released() -> void:
	if CanPress(): 
		$CanvasLayer/MoreInfosContent.show()
		Globals.showVideo("Videos/Hololens.webm", 143, 363, 352, 203, "true", "true", "HOLOLENS_CAD", "webm")

func _on_LightSwitch_released() -> void:
	if CanPress(): $LightSwitchedOn.visible = !$LightSwitchedOn.visible
	lightSwitchedOn = $LightSwitchedOn.visible

func _on_DialogOkButton_released() -> void:
	$CanvasLayer/DialogBox.hide()

func isInTheoryBuildingMessage() -> void:
	$CanvasLayer/Control/DialogBox/Content.text = "Du befindest dich nun im Theoriegebäude der HTL. Hier findet der Theorieunterricht statt. Die Tür zum Laborgebäude ist mit einem Code gesichert. Löse die Rätsel der einzelnen Räume, um in das Laborgebäude zu gelangen."
	$CanvasLayer/Control/DialogBox.show()

func _on_DialogOkButton_BuildingInfo_released() -> void:
	$CanvasLayer/Control/DialogBox/Timer.start(0.5)
	$CanvasLayer/Control/DialogBox.hide()
	$CanvasLayer/Control/RoomSelect_AULA2.show()
	$CanvasLayer/Control/RoomSelect_AULA3.show()
	$CanvasLayer/Control/RoomSelect_CLASS2.show()
	$CanvasLayer/Control/RoomSelect_CLASS3.show()
	$CanvasLayer/Control/RoomSelect_MAP2.show()

func _on_DialogOkButton2_released() -> void:
	$CanvasLayer/Control/DialogBox2.hide()

func _on_Timer_timeout() -> void:
	$CanvasLayer/Control/DialogBox2.show()
