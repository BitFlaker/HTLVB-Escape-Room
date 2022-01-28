extends Control

export var justForFunctions := false
var wasInstancedRightNow := true
var previousRoom := 0

func _ready() -> void: 
	if ZZInGameUi.hasShownWarpHint[0] == true: $MapOpen/SkipToLab.show()
	if !justForFunctions: ZZInGameUi.hideAllVisibleTSButtons()

func setValues() -> void:
	$MapOpen/TextEdit.text = Globals.mapCodeEntered
	previousRoom = Globals.currentRoom
	Globals.currentRoom = Globals.Rooms.B_THEORY

func _input(event):
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed == false and !justForFunctions:
		var evLocal = make_input_local(event)
		if !Rect2(Vector2(0,0),$MapOpen.get_rect().size).has_point(evLocal.position):
			if !wasInstancedRightNow and !Rect2(ZZInGameUi.get_node("CanvasLayer/HintButton").rect_global_position, (ZZInGameUi.get_node("CanvasLayer/HintButton").rect_size * ZZInGameUi.get_node("CanvasLayer/HintButton").rect_scale) / rect_scale).has_point(event.position):
				if get_tree().get_root().get_children()[2].get_node_or_null("CanvasLayer/BackgroundUnfocus") != null:
					get_tree().get_root().get_children()[2].get_node("CanvasLayer/BackgroundUnfocus").color = Color(0,0,0,0)
				queue_free()
				if get_tree().get_root().get_children()[2].get_node_or_null("CanvasLayer/VarsAndDesign") != null:
					get_tree().get_root().get_children()[2].get_node("CanvasLayer/VarsAndDesign").canBePressed = true
				elif get_tree().get_root().get_children()[2].get_node_or_null("CanvasLayer2/VarsAndDesign") != null:
					get_tree().get_root().get_children()[2].get_node("CanvasLayer2/VarsAndDesign").canBePressed = true
				Globals.currentRoom = previousRoom
				ZZInGameUi.showAllPrevVisibleTSButtons()
			else: 
				wasInstancedRightNow = false
		else:
			if wasInstancedRightNow: wasInstancedRightNow = false

func _on_RoomSelect_TH_AULA_released() -> void:
	Globals.openNewRoomWithVideo("Videos/Aula.webm", "res://scenes/rooms/Theory/Room_TH_AULA.tscn")

func _on_RoomSelect_TH_CLASS_released() -> void:
	Globals.openNewRoomWithVideo("Videos/Klasse.webm", "res://scenes/rooms/Theory/Room_TH_CLASS.tscn")

func _on_RoomSelect_TH_ADMIN_released() -> void:
	Globals.openNewRoomWithVideo("Videos/SEK.webm", "res://scenes/rooms/Theory/Room_TH_ADMIN.tscn")

func _on_RoomSelect_TH_NAWI_released() -> void:
	Globals.openNewRoomWithVideo("Videos/NWI.webm", "res://scenes/rooms/Theory/Room_TH_NAWI.tscn")

func _on_RoomSelect_TH_GYM_released() -> void:
	Globals.openNewRoomWithVideo("Videos/Turnsaal.webm", "res://scenes/rooms/Theory/Room_TH_GYM.tscn")

func _on_CodeOK_released() -> void:
	CheckCode(true)

func _on_TextEdit_text_changed(new_text: String) -> void: 
	Globals.mapCodeEntered = $MapOpen/TextEdit.text
	CheckCode(false)

func CheckCode(withErrorMessage:bool) -> void:
	var parts = Globals.code
	var code = str(parts[0], parts[1], parts[2], parts[3], parts[4])
	if $MapOpen/TextEdit.text == code:
		Globals.openNewRoomWithVideo("Videos/ThToLab.webm", "res://scenes/rooms/Laboratory/Building_Laboratory.tscn")
	elif withErrorMessage:
		$CanvasLayer/DialogBox.show()

func _on_SkipToLab_pressed() -> void: ZZInGameUi.showTheoryWarpHint(true)

func _on_DialogOkButton_released() -> void:
	$CanvasLayer/DialogBox.hide()
