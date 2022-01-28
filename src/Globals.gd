extends Node2D

var currentRoom := 0
var openVideos = []
var rnd = RandomNumberGenerator.new()
var mapCodeEntered := ""
var settingsVolume = 100
var settingsMusic = 100
var settingsSFX = 100
var mediaQuality = MediaQuality.low
var shownLabMessage = false

var code
var CODE_ADMIN
var CODE_AULA
var CODE_CLASS
var CODE_GYM
var CODE_NAWI

var codeLAB
var CODE_MZW
var CODE_COMLAB
var CODE_LABS
var labDivNums = [16, 18, 24, 36, 48, 72]
var takenLabDivNum

var codeWS
var CODE_CL1
var CODE_CL2
var CODE_CL3
var CODE_CL4
var CODE_CL5

func _ready() -> void:
	rnd.randomize()
	code = [7, rnd.randi_range(0,9), 6, 7, 2]
	CODE_ADMIN = code[4]
	CODE_AULA = code[3]
	CODE_CLASS = code[1]
	CODE_GYM = code[0]
	CODE_NAWI = code[2]
	
	takenLabDivNum = labDivNums[rnd.randi_range(0,labDivNums.size() - 1)]
	codeLAB = [rnd.randi_range(1,9), 144 / takenLabDivNum, rnd.randi_range(1,9)]
	CODE_MZW = codeLAB[0]
	CODE_LABS = codeLAB[1]
	CODE_COMLAB = codeLAB[2]
	
	codeWS = [7, rnd.randi_range(0,9), 2, 8, rnd.randi_range(0,9)]
	CODE_CL1 = codeWS[0]
	CODE_CL2 = codeWS[1]
	CODE_CL3 = codeWS[2]
	CODE_CL4 = codeWS[3]
	CODE_CL5 = codeWS[4]
	
	for r in Rooms.values():
		roomHintCount.append(0)

func _input(_event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_T) and Input.is_key_pressed(KEY_C): print(str("theory ", code))
	elif Input.is_key_pressed(KEY_L) and Input.is_key_pressed(KEY_C): print(str("laboratory ", codeLAB))
	elif Input.is_key_pressed(KEY_W) and Input.is_key_pressed(KEY_C): print(str("workshop ", codeWS))
	if Input.is_key_pressed(KEY_J) and Input.is_key_pressed(KEY_W):
		if Globals.openVideos.size() > 0:
			for vid in Globals.openVideos:
				Globals.removeElement(vid)
			Globals.openVideos.clear()
		get_tree().change_scene("res://scenes/rooms/Workshop/Building_Workshop.tscn")
	if Input.is_key_pressed(KEY_J) and Input.is_key_pressed(KEY_L):
		if Globals.openVideos.size() > 0:
			for vid in Globals.openVideos:
				Globals.removeElement(vid)
			Globals.openVideos.clear()
		get_tree().change_scene("res://scenes/rooms/Laboratory/Building_Laboratory.tscn")

func showVideo(url: String, posX: int, posY: int, width: int, height: int, enableControls: String, enableAutoplay: String, id: String, videoFormatType:String):
	var paths = [
		"res://ExternalWebGame/index.js",
	]

	var file = File.new()
	var js = '' 
	for path in paths:
		file.open(path, File.READ)
		js += file.get_as_text() + '\n'
		file.close()
	JavaScript.eval(js, true)
	var windowWidth = ProjectSettings.get_setting("display/window/size/width")
	var windowHeight = ProjectSettings.get_setting("display/window/size/height")
	JavaScript.eval("showVideo('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')" % [url, posX, posY, width, height, windowWidth, windowHeight, enableControls, enableAutoplay, id, videoFormatType], true)
	openVideos.append(id)

func isTouchDevice():
	var paths = [
		"res://ExternalWebGame/index.js",
	]
	
	var file = File.new()
	var js = '' 
	for path in paths:
		file.open(path, File.READ)
		js += file.get_as_text() + '\n'
		file.close()
	JavaScript.eval(js, true)
	return (str(JavaScript.eval("is_touch_device()", true)).to_lower() == "true")

func getRewardContent(path:String) -> String:
	var paths = [
		"res://ExternalWebGame/index.js",
	]
	
	var file = File.new()
	var js = '' 
	for path in paths:
		file.open(path, File.READ)
		js += file.get_as_text() + '\n'
		file.close()
	JavaScript.eval(js, true)
	return str(JavaScript.eval("loadFile('%s')" % [path], true))

func isOnMacOs():
	var res: bool = JavaScript.eval("navigator.platform.toLowerCase().includes('mac')")
	return res

func idExists(id: String) -> bool:
	var jscode = "String(!!document.getElementById('%s'))" % [id]
	return (JavaScript.eval(jscode, true) == "true")

func removeElement(id: String) -> void:
	if openVideos.has(id):
		var pos = openVideos.find(id)
		openVideos.remove(pos)
	JavaScript.eval("document.body.removeChild(document.getElementById('%s'))" % [id], true)

func showWebPage(titel: String, url: String):
	var paths = [
		"res://ExternalWebGame/index.js",
	]

	var file = File.new()
	var js = '' 
	for path in paths:
		file.open(path, File.READ)
		js += file.get_as_text() + '\n'
		file.close()
	JavaScript.eval(js, true)
	JavaScript.eval("showWebsite('%s', '%s')" % [titel, url], true)

func openNewRoomWithVideo(videoURL:String, finishRoomEnterPath:String) -> void:
	var root = get_tree().get_root()
	var tree = get_tree()
	var level
	var globalScenes = ["Globals", "ZZInGameUi"]
	
	for c in get_tree().get_root().get_children():
		if !globalScenes.has(c.name):
			level = c
			break
	root.remove_child(level)
	level.call_deferred("free")
	
	var next_level_resource = load("res://scenes/general/PreRoomEnterVideo.tscn")
	var next_level = next_level_resource.instance()
	root.add_child(next_level)
	root.get_node("PreRoomEnterVideo").videoURL = videoURL
	root.get_node("PreRoomEnterVideo").finishRoomEnterPath = finishRoomEnterPath
	root.get_node("PreRoomEnterVideo").start()
	tree.set_current_scene(next_level)

enum MediaQuality {
	low,
	medium,
	high
}

enum Rooms {
	CAD,
	GYM,
	NAWI,
	ADMIN,
	CLASS,
	AULA,
	MZW,
	LAB,
	COM_LAB,
	WS_NUTCRACKER,
	WS_FIREBASKET,
	WS_SERIAL_PROD,
	WS_CAD_CAM,
	WS_AUTOMATION,
	B_THEORY,
	B_LABORATORY,
	B_WS
}

var hints = [
	[["Bei der Code-Eingabe findest du wichtige Informationen.", 30], ["Drehe das 3D-Modell in die Position \"Top\". Zoome in das Bild hinein.", 60], ["Wenn du nochmal auf den Hinweisbutton klickst, bekommst du die Lösung, erhältst jedoch eine Zeitrafe von 10 Minuten.", 0], ["Mit diesem Code kommst du durch die Tür: 7428", 600]],
	[["Achte auf den Sperrbildschirm.", 30], ["Ein menschliches Faultier heisst auf Englisch Lazy Bone. Welche Nummer hat die Station mit diesem Namen?", 60], ["Wenn du nochmal auf den Hinweisbutton klickst, bekommst du die Lösung, erhältst jedoch eine Zeitrafe von 10 Minuten.", 0], ["Die Lösungszahl für diesen Raum ist: 7", 600]],
	[["Du musst bei jedem Video etwas zählen.", 30], ["Addiere die Zahlen und bilde am Schluss die Quersumme.",60], ["Wenn du nochmal auf den Hinweisbutton klickst, bekommst du die Lösung, erhältst jedoch eine Zeitrafe von 10 Minuten.", 0], ["Die Lösungszahl für diesen Raum ist: 6", 600]],
	[["Frage im Sekretariat nach dem Reihungswert von Muster Niki.", 30], ["Zwei mal Mathematiknote + Deutschnote + Englischnote = Reihungswert", 60], ["Bilde die Quersumme vom Reihungswert.", 90], ["Wenn du nochmal auf den Hinweisbutton klickst, bekommst du die Lösung, erhältst jedoch eine Zeitrafe von 10 Minuten.", 0], ["Die Lösungszahl für diesen Raum ist: 2", 600]],
	[["Schau dir die Stundenpläne genauer an.", 30], ["Du kannst die roten Kreise in den Stundenplänen anklicken.", 60], ["Achte auf die Schreibweise der Erklärungen.", 90], ["Wenn du nochmal auf den Hinweisbutton klickst, bekommst du die Lösung, erhältst jedoch eine Zeitrafe von 10 Minuten. ", 0], ["Schreibe \"Matura\" in die Kästchen. Dann erscheint die richtige Zahl.", 600]],
	[["Welche Zahl versteckt sich mehrfach im Bild?", 30], ["Wie viele Abteilungen gibt es an der HTL Vöcklabruck?", 60], ["Wenn du nochmal auf den Hinweisbutton klickst, bekommst du die Lösung, erhältst jedoch eine Zeitrafe von 10 Minuten.", 0], ["Die Lösungszahl für diesen Raum ist: 7", 600]],
	[["Sieh dir die Weltkarte nochmal an.", 30], ["Füge die Platznummer in die Sterne ein. Achte auf die Länder.", 60], ["Wenn du nochmal auf den Hinweisbutton klickst, bekommst du die Lösung, erhältst jedoch eine Zeitrafe von 10 Minuten.", 0], ["Hier die Lösung für die Weltkarte: Griechenland: 1, Spanien: 2, Belgien: 3, Schweden: 4", 600]],
	[["Klicke auf das Handy.", 30], ["Teile die Zahl vom Rätsel durch die Zahl von der Notiz.",60]],
	[["Binäres Zahlensystem", 30], ["Wie sieht die Zahl im Dezimalsystem aus?", 60]],
	[["Sieh dir das Video genau an, um die richtigen Zuordnungen zu finden.", 30], ["Klicke auf das Wort \"Nussknacker\" um zum Rätsel zu gelangen.", 60]],
	[["Die Geräusche passen zu einem Bild.", 30], ["Füge die Zahlen vom Bild in die richtigen Felder unter den Kopfhörern ein.", 60]],
	[["Achte auf die Box rechts unten.", 30]],
	[["Welche Zahl kannst du in dem Video oft erkennen?", 30]],
	[["Putze die Zähne von Spongebob.", 30], ["Achte im Video auf die richtige Bewegung der Zahnbürste.", 60]],
	[["Schau dir die Videos zu den einzelnen Räumen an.", 30], ["Die Reihenfolge der Zahlen orientiert sich an den Raumnummern. Die findest du in den Videos.", 60], ["Gib die Zahlen in folgender Reihenfolge ein: Turnsaal - Klasse - Nawi - Aula - Sekretariat", 90]],
	[["Achte auf versteckte Bilder.", 30], ["Die Reihenfolge der Zahlen orientiert sich an den Bildern, die an der Tür und in den Rätseln versteckt sind.", 60]],
	[["Achte auf die Zahlen im Bild.", 30], ["Die Reihenfolge der Zahlen orientiert sich an den Klassenstufen.", 60]]
]

var roomHintCount = []

func getRoomHintCount(roomID:int) -> int:
	return roomHintCount[roomID]

func addRoomHintCount(roomID:int, count:int) -> void:
	if hints[roomID].size() - 1 < roomHintCount[roomID] + count: return
	roomHintCount[roomID] = roomHintCount[roomID] + count
