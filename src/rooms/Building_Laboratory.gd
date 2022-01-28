extends Node2D

var preRoomClip = load("res://scenes/general/PreRoomEnterVideo.tscn")

func _ready() -> void:
	Globals.currentRoom = Globals.Rooms.B_LABORATORY
	if !Globals.shownLabMessage:
		$BackLayer/DialogBox/Content.text = "Du befindest dich nun im Laborgebäude der HTL. Hier finden praktische Übungen zu den technischen Gegenständen statt. Die Tür zum Werkstattgebäude ist mit einem Code gesichert. Löse die Rätsel der einzelnen Räume, um in die Werkstatt zu gelangen."
		$BackLayer/DialogBox.show()
		Globals.shownLabMessage = true

func _process(delta: float) -> void:
	if ZZInGameUi.hasShownWarpHint[1] == true: $BackLayer/Pad/SkipToWorkshop.show()

func _on_NumPadUnlock_released() -> void:
	$BackLayer/PadBackground.show()
	$BackLayer/Pad.show()
	$Clickables.hide()

func _on_EG_released() -> void:
	Globals.openNewRoomWithVideo("Videos/Computerlabor.webm", "res://scenes/rooms/Laboratory/Room_LB_COM-LAB.tscn")

func _on_Laboratories_released() -> void:
	Globals.openNewRoomWithVideo("Videos/Labore.webm", "res://scenes/rooms/Laboratory/Room_LB_LAB.tscn")

func _on_OG_released() -> void:
	Globals.openNewRoomWithVideo("Videos/MZW.webm", "res://scenes/rooms/Laboratory/Room_LB_MZW.tscn")

func _on_DialogOkButton_released() -> void:
	if $BackLayer/DialogBox/Content.text == "Du befindest dich nun im Laborgebäude der HTL. Hier finden praktische Übungen zu den technischen Gegenständen statt. Die Tür zum Werkstattgebäude ist mit einem Code gesichert. Löse die Rätsel der einzelnen Räume, um in die Werkstatt zu gelangen.":
		$BackLayer/DialogBox/Content.text = "Klicke auf die Wörter \"KG\", \"EG\", oder \"OG\" um zu den Rätseln zu gelangen."
		$BackLayer/DialogBox/Note.scale.y = 0.488
		$BackLayer/DialogBox/DialogOkButton.position.y = 400
		$BackLayer/DialogBox/DialogOkButton.scale.y = 0.083
	else:
		$BackLayer/DialogBox.hide()

func _on_SkipToWorkshop_pressed() -> void:
	ZZInGameUi.showLabWarpHint(true)
