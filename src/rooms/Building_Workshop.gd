extends Node2D

var _globals
var isInClassSubMenu := false
var playingAnyAudio := false
var codeSequence := []
var workplacePos := ["AngleGrinder", "Welding", "Smithing"]
var rnd = RandomNumberGenerator.new()

func _ready() -> void:
	$BackLayer/DialogBox/Content.text = "Du befindest dich nun in der Werkstatt der HTL. Hier lernst du handwerkliche Fähigkeiten und baust jedes Jahr neue Werkstücke. Die Tür ins Freie ist mit einem Code gesichert. Löse die Rätsel der einzelnen Werkstücke um das Gebäude zu verlassen."
	$BackLayer/DialogBox.show()
	rnd.randomize()
	_globals = get_tree().get_root().get_node("Globals")
	var strm
	strm = $SmithingSound.stream as AudioStreamOGGVorbis
	strm.set_loop(false)
	strm = $WeldingSound.stream as AudioStreamOGGVorbis
	strm.set_loop(false)
	strm = $AngleGrinderSound.stream as AudioStreamOGGVorbis
	strm.set_loop(false)
	var available = [1,2,3]
	while available.size() > 0:
		var posToAppend = rnd.randi_range(0,available.size() - 1)
		codeSequence.append(available[posToAppend])
		available.remove(posToAppend)
	Globals.currentRoom = Globals.Rooms.B_WS

func _on_ShowAllParts_released() -> void:
	if !$AnimationPlayer.is_playing():
		$AnimationPlayer.play("ShowParts")

func ShowedPartes() -> void:
	$WorkshopOverview/ShowAllParts.hide()
	$BackButton.show()

func HidParts() -> void:
	$WorkshopOverview/ShowAllParts.show()
	$BackButton.hide()

func _on_BackButton_released() -> void:
	if !$AnimationPlayer.is_playing():
		$AnimationPlayer.play("HideParts")

func _on_Class1_released() -> void:
#	$BackLayer/VideoRectBackground.show()
#	Globals.showVideo("Videos/DrehenUndFertigeWerkstuecke.webm", 0, 0, 1024, 551, "true", "true", "NUTCRACKER_KEEPVID", "webm")
#	$BackLayer/SkipButton.show()
	$BackButton.hide()
	$WorkshopParts.hide()
	$BackLayer/Nutcracker.show()
#	ZZInGameUi.hideAll()
	Globals.currentRoom = Globals.Rooms.WS_NUTCRACKER
	

func _on_Class4_released() -> void:
	isInClassSubMenu = true
	$BackLayer/VideoRectBackground.show()
	Globals.showVideo("Videos/cad_cam.webm", 0, 0, 1024, 551, "true", "true", "CAD_CAM_Video_KEEPVID", "webm")
	$BackLayer/SkipButton.show()
	$WorkshopParts.hide()
	Globals.currentRoom = Globals.Rooms.WS_CAD_CAM
	ZZInGameUi.hideAll()

func _on_SkipButton_released() -> void:
	if Globals.idExists("CAD_CAM_Video_KEEPVID"):
		Globals.removeElement("CAD_CAM_Video_KEEPVID")
		$BackLayer/SkipButton.hide()
		$BackLayer/VideoRectBackground.hide()
		isInClassSubMenu = false
		$WorkshopParts.show()
	elif Globals.idExists("SPBOB_KEEPVID"):
		Globals.removeElement("SPBOB_KEEPVID")
		$BackLayer/SkipButton.hide()
		$BackLayer/VideoRectBackground.hide()
		$BackLayer/Automation.show()
#	elif Globals.idExists("NUTCRACKER_KEEPVID"):
#		Globals.removeElement("NUTCRACKER_KEEPVID")
#		$BackLayer/SkipButton.hide()
#		$BackLayer/VideoRectBackground.hide()
#		$BackLayer/Nutcracker.show()
	elif Globals.idExists("DREHEN_KEEPVID"):
		Globals.removeElement("DREHEN_KEEPVID")
		$BackLayer/SkipButton.hide()
		$BackLayer/VideoRectBackground.hide()
	elif Globals.idExists("FRAESEN_KEEPVID"):
		Globals.removeElement("FRAESEN_KEEPVID")
		$BackLayer/SkipButton.hide()
		$BackLayer/VideoRectBackground.hide()
	elif Globals.idExists("NUTCRACKER_VID_KEEPVID"):
		Globals.removeElement("NUTCRACKER_VID_KEEPVID")
		$BackLayer/SkipButton.hide()
		$BackLayer/VideoRectBackground.hide()
		OS.shell_open("https://learningapps.org/watch?v=p2dxknd0320")
	elif Globals.idExists("SERIENFERTIGUNG_KEEPVID"):
		Globals.removeElement("SERIENFERTIGUNG_KEEPVID")
		$BackLayer/SkipButton.hide()
		$BackLayer/VideoRectBackground.hide()
		$WorkshopParts.show()
		$BackButton.show()
		OS.shell_open("https://www.jigsawexplorer.com/online-jigsaw-puzzle-player.html?url=aHR0cHM6Ly9pLmltZ3VyLmNvbS9hSXZOVzZWLnBuZ18obm9fcHJldmlld180KV8obm9wPTMwKQ~~")
	ZZInGameUi.showAll()

func _on_PlayAudio1_released() -> void:
	HandleMusicPlaying(0)

func _on_PlayAudio2_released() -> void:
	HandleMusicPlaying(1)

func _on_PlayAudio3_released() -> void:
	HandleMusicPlaying(2)

func HandleMusicPlaying(index:int) -> void:
	var player = get_node(str(workplacePos[codeSequence[index] - 1], "Sound"))
	if !playingAnyAudio:
		playingAnyAudio = true
		player.play(0)
	elif player.playing:
		player.stop()
		playingAnyAudio = false

func AudioFinished() -> void:
	playingAnyAudio = false

func _on_BackButtonFromFifthC_released() -> void:
	if Globals.idExists("FirebasketSoundsVideoInfo"): Globals.removeElement("FirebasketSoundsVideoInfo")
	if $SmithingSound.playing: $SmithingSound.stop()
	if $WeldingSound.playing: $WeldingSound.stop()
	if $AngleGrinderSound.playing: $AngleGrinderSound.stop()
	playingAnyAudio = false
	$BackLayer/Firebasket.hide()
	$BackButton.show()
	$WorkshopParts.show()

func FifthClassCodeChanged(_new_text: String) -> void:
	checkForCorrectCodeFirebasket()

func checkForCorrectCodeFirebasket() -> void:
	var ccontainer = $BackLayer/Firebasket/Feuerkorbraetsel_low
	var code = str(ccontainer.get_node("Audio1").text, ccontainer.get_node("Audio2").text, ccontainer.get_node("Audio3").text)
	var expectedCode = str(codeSequence[0], codeSequence[1], codeSequence[2])
	if code == expectedCode:
		$BackLayer/Firebasket/Label.text = str(_globals.CODE_CL2)
		$AnimationPlayer.play("FifthClassNumber")
		$BackLayer/Firebasket/Feuerkorbraetsel_low/OpenAngleGrinder.hide()
		$BackLayer/Firebasket/Feuerkorbraetsel_low/OpenFireBasket.hide()
		$BackLayer/Firebasket/Feuerkorbraetsel_low/OpenSmithing.hide()
		$BackLayer/Firebasket/Feuerkorbraetsel_low/PlayAudio1.hide()
		$BackLayer/Firebasket/Feuerkorbraetsel_low/PlayAudio2.hide()
		$BackLayer/Firebasket/Feuerkorbraetsel_low/PlayAudio3.hide()

func _on_Class2_released() -> void:
	if !$AnimationPlayer.is_playing():
		$BackButton.hide()
		$BackLayer/Firebasket.show()
	$WorkshopParts.hide()
	Globals.currentRoom = Globals.Rooms.WS_FIREBASKET

func _on_Class3_released() -> void:
	$BackLayer/VideoRectBackground.show()
	Globals.showVideo("Videos/Serienfertigung_Werkstatt.webm", 0, 0, 1024, 551, "true", "true", "SERIENFERTIGUNG_KEEPVID", "webm")
	$BackLayer/SkipButton.show()
	$BackButton.hide()
	$WorkshopParts.hide()
	ZZInGameUi.hideAll()
	Globals.currentRoom = Globals.Rooms.WS_SERIAL_PROD
#	OS.shell_open("")

func _on_BackButtonFromSpbob_released() -> void:
	$BackLayer/Automation.hide()
	$BackButton.show()
	$WorkshopParts.show()

func _on_Class5_released() -> void:
	$BackLayer/VideoRectBackground.show()
	Globals.showVideo("Videos/spongebob.webm", 0, 0, 1024, 551, "true", "true", "SPBOB_KEEPVID", "webm")
	$BackLayer/SkipButton.show()
	$BackButton.hide()
	$WorkshopParts.hide()
	ZZInGameUi.hideAll()
	Globals.currentRoom = Globals.Rooms.WS_AUTOMATION

func _on_CodeEnter_released() -> void:
	$WorkshopOverview/CodeEnter.hide()
	$WorkshopOverview/ShowAllParts.hide()
	$BackLayer/Pad.show()
	$BackLayer/PadBackground2.show()
	Globals.currentRoom = Globals.Rooms.B_WS
	ZZInGameUi.hideAllVisibleTSButtons()
	for c in $BackLayer/Pad.get_children(): if c is TouchScreenButton: c.show()

func _on_CheckEnteredData_released() -> void:
	checkForCorrectCodeFirebasket()

func _on_DialogOkButton_released() -> void:
	$BackLayer/DialogBox.hide()
	$WorkshopOverview/ShowAllParts.show()
	$WorkshopOverview/CodeEnter.show()

func _on_DialogOkButtonFB_released() -> void:
	$BackLayer/Firebasket/DialogBox.hide()
	for c in $BackLayer/Firebasket/Feuerkorbraetsel_low.get_children():
		c.show()

func _on_DialogOkButtonAM_released() -> void:
	$BackLayer/Automation/DialogBox.hide()

func _on_DialogOkButtonNC_released() -> void:
	$BackLayer/Nutcracker/DialogBox.hide()
	for c in $BackLayer/Nutcracker/Nussknacker.get_children():
		c.show()
		print("SHWON")

func _on_BackButtonNC_released() -> void:
	$BackLayer/Nutcracker.hide()
	$BackButton.show()
	$WorkshopParts.show()

func _on_GLGFraes_released() -> void:
	print("RELEASED")
	$BackLayer/VideoRectBackground.show()
	Globals.showVideo("Videos/Fraesen.webm", 0, 0, 1024, 551, "true", "true", "FRAESEN_KEEPVID", "webm")
	$BackLayer/SkipButton.show()
	ZZInGameUi.hideAll()

func _on_GLGDreh_released() -> void:
	print("RELEASED")
	$BackLayer/VideoRectBackground.show()
	Globals.showVideo("Videos/Drehen.webm", 0, 0, 1024, 551, "true", "true", "DREHEN_KEEPVID", "webm")
	$BackLayer/SkipButton.show()
	ZZInGameUi.hideAll()

func _on_NutCracker_released() -> void:
	print("RELEASED")
	$BackLayer/VideoRectBackground.show()
	Globals.showVideo("Videos/nussknacker.webm", 0, 0, 1024, 551, "true", "true", "NUTCRACKER_VID_KEEPVID", "webm")
	$BackLayer/SkipButton.show()
	ZZInGameUi.hideAll()
