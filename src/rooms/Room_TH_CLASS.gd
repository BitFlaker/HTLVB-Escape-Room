extends Node2D

var subj_text_FET_H = "FET\nFertigungstechnik"
var subj_text_FET = "\n\n\n\nWelche Werkstoffe werden in\nF<A>hrzeugen\nverwendet und wie kann man diese Werkstoffe bearbeiten?"
var subj_text_PLP_H = "PLP\nPlanung und Projektierung"
var subj_text_PLP = "\n\n\n\n\nEn<T>wurf einer Heizungs-, Kältetechnik-, Lüftungs- und Sanitäranlage"
var subj_text_TMB_H = "TMB\nTechnische Mechanik und Berechnung"
var subj_text_TMB = "\n\n\n\n\nSt<A>tik einer Eisenbahnbrücke berechnen"
var subj_text_AIIT_H = "AIIT\nAngewandte Informatik und fachspezifische Informationstechnik"
var subj_text_AIIT = "\n\n\n\n\nProgrammieren von\n<M>icrocomputern in Haushaltsgeräten oder Garagentoren"
var subj_text_SWP_H = "SWP\nSoftwareentwicklung und Projektmanagement"
var subj_text_SWP = "\n\n\n\n\nWie prog<R>ammiert man ein Computerspiel?"
var subj_text_BET_H = "BET\nBetriebstechnik"
var subj_text_BET = "\n\n\n\n\nWie ist ein <U>nternehmen aufgebaut und organisiert?"
var offsetToReach = Vector2.ZERO
var prev := -1
var currentCLASS = ""

func _ready() -> void:
	if Globals.calledRoomBySelector != Globals.RoomCall.None: 
		$CanvasLayer/BackButton.show()
		$CanvasLayer2/VarsAndDesign.queue_free()
		ZZInGameUi.onlyShowButtons()
	Globals.currentRoom = Globals.Rooms.CLASS

func _process(_delta: float) -> void:
	if $CanvasLayer/BackgroundUnfocus.color == Color(0,0,0,0):
		$CanvasLayer/BackgroundUnfocus.hide()
	if $Code/AIIT.text.to_lower() == "m" and $Code/TMB.text.to_lower() == "a" and $Code/PLP.text.to_lower() == "t" and $Code/BET.text.to_lower() == "u" and $Code/SWP.text.to_lower() == "r" and $Code/FET.text.to_lower() == "a":
		set_process(false)
		if Globals.calledRoomBySelector != Globals.RoomCall.None: 
			Globals.returnToSelector()
		else:
			var codeNum = Globals.CODE_CLASS
			$CanvasLayer/Label.text = str(codeNum)
			$AnimationPlayer.play("showUpNumber")

func zoomToTimetable(pos:Vector2, size:Vector2, _class:String) -> void:
	if IsMapOpen(): return
	if $Camera2D.current_zoom != Vector2(1,1): zoomReset()
	currentCLASS = _class
	$Camera2D.zoom_in((pos + (size / Vector2(2,2))) - $Camera2D.get_camera_position())

func zoomReset() -> void:
	currentCLASS = ""
	$Camera2D.zoom_out(Vector2(512,300))

func _on_DialogClose_pressed() -> void:
	$CanvasLayer/DialogBox.hide()

func setTextAndShowDialog(subject:String, _class:String) -> void:
	if IsMapOpen(): return
	$CanvasLayer/DialogBox/Heading.show()
	var wasSet = false
	if subject == "FET": if currentCLASS == _class:
		$CanvasLayer/DialogBox/Heading.text = subj_text_FET_H
		$CanvasLayer/DialogBox/RichTextLabel.text = subj_text_FET
		wasSet = true
	if subject == "PLP":  if currentCLASS == _class: 
		$CanvasLayer/DialogBox/Heading.text = subj_text_PLP_H
		$CanvasLayer/DialogBox/RichTextLabel.text = subj_text_PLP 
		wasSet = true
	if subject == "TMB": if currentCLASS == _class: 
		$CanvasLayer/DialogBox/Heading.text = subj_text_TMB_H 
		$CanvasLayer/DialogBox/RichTextLabel.text = subj_text_TMB 
		wasSet = true
	if subject == "AIIT": if currentCLASS == _class: 
		$CanvasLayer/DialogBox/Heading.text = subj_text_AIIT_H 
		$CanvasLayer/DialogBox/RichTextLabel.text = subj_text_AIIT 
		wasSet = true
	if subject == "SWP": if currentCLASS == _class: 
		$CanvasLayer/DialogBox/Heading.text = subj_text_SWP_H 
		$CanvasLayer/DialogBox/RichTextLabel.text = subj_text_SWP 
		wasSet = true
	if subject == "BET": if currentCLASS == _class: 
		$CanvasLayer/DialogBox/Heading.text = subj_text_BET_H 
		$CanvasLayer/DialogBox/RichTextLabel.text = subj_text_BET 
		wasSet = true
	if wasSet: $CanvasLayer/DialogBox.show()

func _on_TouchBackButton_released() -> void:
	$CanvasLayer2/BackButton.hide()
	$SpecialitiesSelection.show()
	$timetable_1afmbm.hide()
	$timetable_1ahgti.hide()
	$timetable_1ahmbt.hide()
	$timetable_1ahwim.hide()
	$timetable_1ahwii.hide()
	$timetable_1ahme.hide()

##############
#  SUBJECTS  #
##############

func _on_mbm_subj_pressed() -> void:
	setTextAndShowDialog("FET", "FS")

func _on_gti_subj_pressed() -> void:
	setTextAndShowDialog("PLP", "GT")

func _on_mbt_subj_pressed() -> void:
	setTextAndShowDialog("TMB", "MB")

func _on_me_subj_pressed() -> void:
	setTextAndShowDialog("AIIT", "ME")

func _on_wii_subj_pressed() -> void:
	setTextAndShowDialog("SWP", "WI")

func _on_wim_subj_pressed() -> void:
	setTextAndShowDialog("BET", "WM")

##############
# CATEGORIES #
##############

func _on_FS_category_released() -> void:
	$ColorRect.rect_position = $SpecialitiesSelection/buttonFS.get_global_transform().get_origin()# + Vector2(0,50)
	$ColorRect.rect_size = $SpecialitiesSelection/buttonFS.get_global_transform().get_scale() * Vector2(823,730)
	zoomToTimetable($ColorRect.rect_position, $ColorRect.rect_size, "FS")

func _on_GT_category_released() -> void:
	$ColorRect.rect_position = $SpecialitiesSelection/buttonGT.get_global_transform().get_origin()
	$ColorRect.rect_size = $SpecialitiesSelection/buttonGT.get_global_transform().get_scale() * Vector2(823,730)
	zoomToTimetable($ColorRect.rect_position, $ColorRect.rect_size, "GT")

func _on_MB_category_released() -> void:
	$ColorRect.rect_position = $SpecialitiesSelection/buttonMB.get_global_transform().get_origin()
	$ColorRect.rect_size = $SpecialitiesSelection/buttonMB.get_global_transform().get_scale() * Vector2(823,730)
	zoomToTimetable($ColorRect.rect_position, $ColorRect.rect_size, "MB")

func _on_WM_category_released() -> void:
	$ColorRect.rect_position = $SpecialitiesSelection/buttonWM.get_global_transform().get_origin()
	$ColorRect.rect_size = $SpecialitiesSelection/buttonWM.get_global_transform().get_scale() * Vector2(823,730)
	zoomToTimetable($ColorRect.rect_position, $ColorRect.rect_size, "WM")

func _on_WI_category_released() -> void:
	$ColorRect.rect_position = $SpecialitiesSelection/buttonWI.get_global_transform().get_origin()
	$ColorRect.rect_size = $SpecialitiesSelection/buttonWI.get_global_transform().get_scale() * Vector2(823,730)
	zoomToTimetable($ColorRect.rect_position, $ColorRect.rect_size, "WI")

func _on_ME_category_released() -> void:
	$ColorRect.rect_position = $SpecialitiesSelection/buttonME.get_global_transform().get_origin()
	$ColorRect.rect_size = $SpecialitiesSelection/buttonME.get_global_transform().get_scale() * Vector2(823,730)
	zoomToTimetable($ColorRect.rect_position, $ColorRect.rect_size, "ME")

func IsMapOpen() -> bool:
	return get_node_or_null("CanvasLayer/Map") != null

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed == false and $Camera2D.current_zoom == Vector2($Camera2D.zoom_factor,$Camera2D.zoom_factor):
		var evLocal = make_input_local(event)
		
		if !Rect2($ColorRect.get_global_rect().position,$ColorRect.get_rect().size).has_point(evLocal.position):
			zoomReset()

func playAnim() -> void:
	$AnimationPlayer.play("numberAnim")

func _on_AcceptCode_released() -> void:
	if $Code/AIIT.text.to_lower()[0] == 'm' and $Code/TMB.text.to_lower()[0] == 'a' and $Code/PLP.text.to_lower()[0] == 't' and $Code/BET.text.to_lower()[0] == 'u' and $Code/SWP.text.to_lower()[0] == 'r' and $Code/FET.text.to_lower()[0] == 'a':
		set_process(false)
		var codeNum = Globals.CODE_CLASS
		$CanvasLayer/Label.text = str(codeNum)
		$AnimationPlayer.play("showUpNumber")

func _on_BackButton_pressed() -> void:
	Globals.returnToSelector()
