extends Node2D

var timeElapsed
var startTime
var hasStarted := false
var penaltySeconds := 0
var doDontHide = ["DialogBox", "FullScreen", "PauseMenu"]
var hiddenTSButtons = []
var pausedTicks := 0
var pauseFrom := 0
var gameFinished = false
var theorytime := 0.0
var theoryWarpLimit := 1800.0
var labWarpTime := 1800.0
var isInBuildingID := 0
var hasShownWarpHint := [false, false]
var hasHidden := false

func _ready() -> void:
	hideAll()

func _process(delta: float) -> void:
	if hasStarted:
		var timeElapsed = OS.get_ticks_msec() - startTime - pausedTicks
		var totalSeconds = int(timeElapsed / 1000) + penaltySeconds
		if isInBuildingID == 0: 
			theorytime = totalSeconds
			if theorytime > theoryWarpLimit: showTheoryWarpHint()
			if Globals.currentRoom == Globals.Rooms.B_LABORATORY: isInBuildingID = 1
		elif totalSeconds - theorytime > labWarpTime: showLabWarpHint()
		var hours = int(totalSeconds / 3600)
		var minutes = (totalSeconds - hours * 3600) / 60
		var seconds = totalSeconds - (hours * 3600 + minutes * 60)
		$CanvasLayer/TimeCounter.text = str("%02d" % hours, ":", "%02d" % minutes, ":", "%02d" % seconds)

func showLabWarpHint(ignoreAlreadyShown:=false) -> void:
	if hasShownWarpHint[1] == true and ignoreAlreadyShown == false: return
	$CanvasLayer/DialogBox/Content.text = "Was ist das? Ein Zettel mit dem Code zur Werkstatt?\nMöchtest du den Zettel verwenden und weitergehen oder lieber die Rätsel selber lösen?"
	$CanvasLayer/DialogBox/DialogOkButton.hide()
	$CanvasLayer/DialogBox/Option1/Label.text = "Ab in die Werkstatt!"
	$CanvasLayer/DialogBox/Option1.show()
	$CanvasLayer/DialogBox/Option2/Label2.text = "Im Laborgebäude bleiben"
	$CanvasLayer/DialogBox/Option2.show()
	$CanvasLayer/DialogBox.show()
	hasShownWarpHint[1] = true

func showTheoryWarpHint(ignoreAlreadyShown:=false) -> void:
	if hasShownWarpHint[0] == true and ignoreAlreadyShown == false: return
	$CanvasLayer/DialogBox/Content.text = "Was ist das? Ein Zettel mit dem Code zum Laborgebäude?\nMöchtest du den Zettel verwenden und weitergehen oder lieber die Rätsel selber lösen?"
	$CanvasLayer/DialogBox/DialogOkButton.hide()
	$CanvasLayer/DialogBox/Option1/Label.text = "Ab ins Laborgebäude!"
	$CanvasLayer/DialogBox/Option1.show()
	$CanvasLayer/DialogBox/Option2/Label2.text = "Im Theoriegebäude bleiben"
	$CanvasLayer/DialogBox/Option2.show()
	$CanvasLayer/DialogBox.show()
	hasShownWarpHint[0] = true

func showCurrentTimer() -> void:
	$CanvasLayer/ColorRect.show()
	$CanvasLayer/TimeCounter.show()

func finished_game() -> void:
	gameFinished = true
	$CanvasLayer/PauseButton.hide()
	$CanvasLayer/HintButton.hide()

func start() -> void:
	if gameFinished: return
	showAll()
	startTime = OS.get_ticks_msec()
	hasStarted = true

func pause(hide:bool) -> void:
	if gameFinished: return
	if hide: hideAll()
	hasStarted = false
	pauseFrom = OS.get_ticks_msec()

func resume() -> void:
	if gameFinished: return
	if !visible: showAll()
	hasStarted = true
	pausedTicks = pausedTicks + (OS.get_ticks_msec() - pauseFrom)

func hideAll() -> void:
	hide()
	for c in $CanvasLayer.get_children():
		if !doDontHide.has(c.name): c.hide()

func showAll() -> void:
	show()
	for c in $CanvasLayer.get_children():
		if !doDontHide.has(c.name): c.show()

func showHint(hint:String, timePenalty:int) -> void:
	if gameFinished: return
	$CanvasLayer/DialogBox/Content.text = hint
	$CanvasLayer/DialogBox/DialogOkButton.show()
	$CanvasLayer/DialogBox.show()
	penaltySeconds = penaltySeconds + timePenalty
	hideAllVisibleTSButtons()

func _on_DialogOkButton_released() -> void:
	$CanvasLayer/DialogBox/Content.text = ""
	$CanvasLayer/DialogBox/DialogOkButton.show()
	$CanvasLayer/DialogBox.hide()
	showAllPrevVisibleTSButtons()

func _on_HintButton_pressed() -> void:
	var roomHintCount = Globals.getRoomHintCount(Globals.currentRoom)
	var timePenalty
	
	# REMOVE VIDEOS
	if Globals.openVideos.size() > 0:
		for vid in Globals.openVideos:
			Globals.removeElement(vid)
		Globals.openVideos.clear()
	
	timePenalty = Globals.hints[Globals.currentRoom][roomHintCount][1]
	showHint(Globals.hints[Globals.currentRoom][roomHintCount][0], timePenalty)
	Globals.hints[Globals.currentRoom][roomHintCount][1] = 0
	Globals.addRoomHintCount(Globals.currentRoom, 1)
	
#	if roomHintCount == 0:
#		timePenalty = 30
#		showHint(Globals.hints[Globals.currentRoom][0], timePenalty)
#		Globals.addRoomHintCount(Globals.currentRoom, 1)
#	else: 
#		timePenalty = 60
#		if roomHintCount > 1: timePenalty = 0
#		showHint(Globals.hints[Globals.currentRoom][Globals.hints[Globals.currentRoom].size() - 1], timePenalty)
#		if roomHintCount == 1: Globals.addRoomHintCount(Globals.currentRoom, 1)
	if timePenalty > 0: 
		$CanvasLayer/PenaltyViewer.text = str("+ ", timePenalty)
		$AnimationPlayer.play("showPenalty")

func _on_FullScreen_pressed() -> void:
	OS.window_fullscreen = !OS.window_fullscreen
	if OS.window_fullscreen: $CanvasLayer/FullScreen.texture_normal = load("res://graphics/menu/no_fullscreen.png")
	else: $CanvasLayer/FullScreen.texture_normal = load("res://graphics/menu/fullscreen.png")

func hideAllVisibleTSButtons() -> void:
	if hasHidden: return
	var level
	var globalScenes = ["Globals", "ZZInGameUi"]
	
	for c in get_tree().get_root().get_children():
		if !globalScenes.has(c.name):
			level = c
			break
	
	for c in level.get_children():
		if c.get_child_count() > 0:
			get_allChildren(c)
		if c is TouchScreenButton and c.visible: 
			var isMap := false
			for i in c.get_path().get_name_count():
				if "map" in c.get_path().get_name(i).to_lower():
					isMap = true
					break;
			if isMap: continue
			c.hide()
			hiddenTSButtons.append(c)
	hasHidden = true

func get_allChildren(parent) -> void:
	for c in parent.get_children():
		if c.get_child_count() > 0:
			get_allChildren(c)
		if c is TouchScreenButton and c.visible:
			var isMap := false
			for i in c.get_path().get_name_count():
				if "map" in c.get_path().get_name(i).to_lower():
					isMap = true
					break;
			if isMap: continue
			c.hide()
			hiddenTSButtons.append(c)

func showAllPrevVisibleTSButtons() -> void:
	for c in hiddenTSButtons:
		if c != null:
			c.show()
	hiddenTSButtons.clear()
	hasHidden = false

func _on_PauseOkButton_released() -> void:
	$CanvasLayer/PauseMenu.hide()
	resume()
	showAllPrevVisibleTSButtons()

func _on_PauseButton_pressed() -> void:
	$CanvasLayer/PauseMenu.show()
	pause(false)
	hideAllVisibleTSButtons()
	if Globals.openVideos.size() > 0:
		for vid in Globals.openVideos:
			Globals.removeElement(vid)
		Globals.openVideos.clear()

func _on_Option1_pressed() -> void:
	if isInBuildingID == 0: Globals.openNewRoomWithVideo("Videos/ThToLab.webm", "res://scenes/rooms/Laboratory/Building_Laboratory.tscn")
	else: Globals.openNewRoomWithVideo("Videos/LabToWS.webm", "res://scenes/rooms/Workshop/Building_Workshop.tscn")
	$CanvasLayer/DialogBox/Option1.hide()
	$CanvasLayer/DialogBox/Option2.hide()
	$CanvasLayer/DialogBox.hide()

func _on_Option2_pressed() -> void:
	$CanvasLayer/DialogBox/Option1.hide()
	$CanvasLayer/DialogBox/Option2.hide()
	$CanvasLayer/DialogBox.hide()
