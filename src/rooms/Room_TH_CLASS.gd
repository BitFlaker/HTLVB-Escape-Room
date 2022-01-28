extends Node2D

var subj_text_FET = "[center][color=#ff9900]FET\nFertigungstechnik\n\n\n[/color][color=#000000]Welche Werkstoffe werden in\nF[color=#4fd128]A[/color]hrzeugen\nverwendet und wie kann man diese Werkstoffe bearbeiten?[/color][/center]"
var subj_text_PLP = "[center][color=#ff9900]PLP\nPlanung und Projektierung\n\n\n[/color][color=#000000]En[color=#4fd128]T[/color]wurf einer Heizungs-, Kältetechnik-, Lüftungs- und Sanitäranlage [/color][/center]"
var subj_text_TMB = "[center][color=#ff9900]TMB\nTechnische Mechanik und Berechnung\n\n\n[/color][color=#000000]St[color=#4fd128]A[/color]tik einer Eisenbahnbrücke berechnen[/color][/center]"
var subj_text_AIIT = "[center][color=#ff9900]AIIT\nAngewandte Informatik und fachspezifische Informationstechnik\n\n\n[/color][color=#000000]Programmieren von \n[color=#4fd128]M[/color]icrocomputern in Haushaltsgeräten oder Garagentoren[/color][/center]"
var subj_text_SWP = "[center][color=#ff9900]SWP\nSoftwareentwicklung und Projektmanagement\n\n\n[/color][color=#000000]Wie prog[color=#4fd128]R[/color]ammiert man ein Computerspiel?[/color][/center]"
var subj_text_BET = "[center][color=#ff9900]BET\nBetriebstechnik\n\n\n[/color][color=#000000]Wie ist ein [color=#4fd128]U[/color]nternehmen aufgebaut und organisiert?[/color][/center]"
var offsetToReach = Vector2.ZERO
var prev := -1
var currentCLASS = ""

func _ready() -> void:
	Globals.currentRoom = Globals.Rooms.CLASS
	$CanvasLayer/DialogBox/RichTextLabel.bbcode_text = "\n\n\n[center]Finde die passenden Buchstaben zu den Fächerkürzeln und tippe sie einzeln in die Kästchen ein.[/center]"
	$CanvasLayer/DialogBox.show()

func _process(_delta: float) -> void:
	if $CanvasLayer/BackgroundUnfocus.color == Color(0,0,0,0):
		$CanvasLayer/BackgroundUnfocus.hide()
	if $Code/AIIT.text.to_lower() == "m" and $Code/TMB.text.to_lower() == "a" and $Code/PLP.text.to_lower() == "t" and $Code/BET.text.to_lower() == "u" and $Code/SWP.text.to_lower() == "r" and $Code/FET.text.to_lower() == "a":
		set_process(false)
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
	var wasSet = false
	if subject == "FET": if currentCLASS == _class: 
		$CanvasLayer/DialogBox/RichTextLabel.bbcode_text = subj_text_FET 
		wasSet = true
	if subject == "PLP":  if currentCLASS == _class: 
		$CanvasLayer/DialogBox/RichTextLabel.bbcode_text = subj_text_PLP 
		wasSet = true
	if subject == "TMB": if currentCLASS == _class: 
		$CanvasLayer/DialogBox/RichTextLabel.bbcode_text = subj_text_TMB 
		wasSet = true
	if subject == "AIIT": if currentCLASS == _class: 
		$CanvasLayer/DialogBox/RichTextLabel.bbcode_text = subj_text_AIIT 
		wasSet = true
	if subject == "SWP": if currentCLASS == _class: 
		$CanvasLayer/DialogBox/RichTextLabel.bbcode_text = subj_text_SWP 
		wasSet = true
	if subject == "BET": if currentCLASS == _class: 
		$CanvasLayer/DialogBox/RichTextLabel.bbcode_text = subj_text_BET 
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
