extends Node2D

var justPressed := false
var isNote := false
var isChatBot := false
var anythingOpen := false
var thisLevelCode

func _ready() -> void:
	thisLevelCode = get_tree().get_root().get_node("Globals").CODE_ADMIN
	Globals.currentRoom = Globals.Rooms.ADMIN
	ZZInGameUi.hideAllVisibleTSButtons()
	$TotallyTopLayer/DialogBox/DialogOkButton.show()

func _on_ZoomAdminNote_released() -> void:
	justPressed = true
	isChatBot = false
	isNote = true
	anythingOpen = true
	$CanvasLayer/BackgroundUnfocus.color = Color(0,0,0,0.48)
	$CanvasLayer/Admin_note.show()
	hideAllButtons()
	$CanvasLayer2/VarsAndDesign.ChangeMapVisibility(false)

func hideAllButtons() -> void:
	$CanvasLayer5/AdminNote/Zeugnis/Zeugnis1.hide()
	$CanvasLayer5/AdminNote/Zeugnis/Zeugnis2.hide()
	$CanvasLayer5/AdminNote/Zeugnis/Zeugnis3.hide()
	$CanvasLayer5/AdminNote/Zeugnis/Zeugnis4.hide()
	$CanvasLayer5/AdminNote/Zeugnis/Zeugnis5.hide()
	$CanvasLayer5/AdminNote/Zeugnis/Zeugnis6.hide()
	$CanvasLayer5/AdminNote/ZoomAdminNote.hide()
	$CanvasLayer5/AdminNote/ZoomAdminNote2.hide()
	$CanvasLayer5/AdminNote/ZoomAdminNote3.hide()
	$CanvasLayer5/AdminNote/ZoomAdminNote4.hide()
	$CanvasLayer5/GetToAdminBot.hide()
	$CanvasLayer5/GetToAdminBot2.hide()

func showAllButtons() -> void:
	$CanvasLayer5/AdminNote/Zeugnis/Zeugnis1.show()
	$CanvasLayer5/AdminNote/Zeugnis/Zeugnis2.show()
	$CanvasLayer5/AdminNote/Zeugnis/Zeugnis3.show()
	$CanvasLayer5/AdminNote/Zeugnis/Zeugnis4.show()
	$CanvasLayer5/AdminNote/Zeugnis/Zeugnis5.show()
	$CanvasLayer5/AdminNote/Zeugnis/Zeugnis6.show()
	$CanvasLayer5/AdminNote/ZoomAdminNote.show()
	$CanvasLayer5/AdminNote/ZoomAdminNote2.show()
	$CanvasLayer5/AdminNote/ZoomAdminNote3.show()
	$CanvasLayer5/AdminNote/ZoomAdminNote4.hide()
	$CanvasLayer5/GetToAdminBot.show()
	$CanvasLayer5/GetToAdminBot2.show()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed == false and anythingOpen:
		var evLocal = make_input_local(event)
		if isNote:
			$CanvasLayer5/NoteClickAwayDeadzone.rect_position = Vector2((1024-600)/2, (600-380)/2)
			$CanvasLayer5/NoteClickAwayDeadzone.rect_size = $CanvasLayer/Admin_note.get_rect().size - Vector2(50,60)
			if !Rect2($CanvasLayer5/NoteClickAwayDeadzone.rect_position,$CanvasLayer5/NoteClickAwayDeadzone.get_rect().size).has_point(evLocal.position):
				if !justPressed:
					ResetAfterBotClose()
					anythingOpen = false
				else:
					justPressed = false
			else:
				justPressed = false
		elif isChatBot == true:
			$CanvasLayer5/NoteClickAwayDeadzone.rect_position = Vector2(1024-(339*0.9), 600-(560*0.9))
			$CanvasLayer5/NoteClickAwayDeadzone.rect_size = Vector2(339*0.9,560*0.9)
			if !Rect2($CanvasLayer5/NoteClickAwayDeadzone.rect_position,$CanvasLayer5/NoteClickAwayDeadzone.get_rect().size).has_point(evLocal.position):
				if !justPressed:
					ResetAfterBotClose()
					anythingOpen = false
					isChatBot = false
					$TotallyTopLayer.remove_child($TotallyTopLayer.get_children()[1])
				else:
					justPressed = false
			else:
				justPressed = false
		else:
			$CanvasLayer5/NoteClickAwayDeadzone.rect_position = Vector2(260, 0)
			$CanvasLayer5/NoteClickAwayDeadzone.rect_size = Vector2(539,600)
			if !Rect2($CanvasLayer5/NoteClickAwayDeadzone.rect_position,$CanvasLayer5/NoteClickAwayDeadzone.get_rect().size).has_point(evLocal.position):
				if !justPressed:
					ResetAfterBotClose()
					anythingOpen = false
				else:
					justPressed = false
			else:
				justPressed = false

func _on_GetToAdminBot_released() -> void:
	var flag = load("res://scenes/general/ChatBotWindow.tscn").instance()
	flag.position = Vector2(1024,600)
	flag.scale = Vector2(0.9, 0.9)
	isChatBot = true
	isNote = false
	justPressed = true
	anythingOpen = true
	$TotallyTopLayer.add_child(flag)
	$CanvasLayer2/VarsAndDesign.ChangeMapVisibility(false)
	$CanvasLayer/BackgroundUnfocus.color = Color(0,0,0,0.48)
	hideAllButtons()

func ResetAfterBotClose() -> void:
	$CanvasLayer/Admin_note.hide()
	$CanvasLayer/Zeugnis.hide()
	$CanvasLayer5/GetToAdminBot.show()
	$CanvasLayer/BackgroundUnfocus.color = Color(0,0,0,0)
	$CanvasLayer2/VarsAndDesign.ChangeMapVisibility(true)
	showAllButtons()

func _on_Zeugnis1_released() -> void:
	justPressed = true
	isNote = false
	anythingOpen = true
	$CanvasLayer/BackgroundUnfocus.color = Color(0,0,0,0.48)
	$CanvasLayer/Zeugnis.show()
	$CanvasLayer5/GetToAdminBot.hide()
	$CanvasLayer2/VarsAndDesign.ChangeMapVisibility(false)
	hideAllButtons()

func _on_DialogOkButton_released() -> void:
	$TotallyTopLayer/DialogBox.hide()
	ZZInGameUi.showAllPrevVisibleTSButtons()
