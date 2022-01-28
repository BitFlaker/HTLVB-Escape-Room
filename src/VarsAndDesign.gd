extends Node2D

export var showMap := true
var map = load("res://scenes/general/MapOpen.tscn")
var canBePressed := true
var _globals

func _ready() -> void:
	_globals = get_tree().get_root().get_node("Globals")
	if !showMap:
		$CanvasLayer/HBoxContainer.hide()
		
var didInitJs = false
func initJs(): 
	if (!didInitJs):
		didInitJs = true
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
		
func isOnMacOs():
	initJs()
	var res: bool = JavaScript.eval("navigator.platform.toLowerCase().includes('mac')")
	return res
	
func showWebPage(titel: String, url: String):
	initJs()
	JavaScript.eval("showWebsite('%s', '%s')" % [titel, url], true)
	
func showWebPageInNewTap(url: String, alertText: String):
	initJs()
	JavaScript.eval("openInNewTab('%s', '%s')" % [url, alertText], true)

func showVideo(url: String, posX: int, posY: int, width: int, height: int):
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
	JavaScript.eval("showVideo('%s', '%s', '%s', '%s', '%s', '%s', '%s')" % [url, posX, posY, width, height, windowWidth, windowHeight], true)

func _on_OpenMapButton_pressed() -> void:
	if _globals.idExists("GymHTLWarriorVideo"):
		_globals.removeElement("GymHTLWarriorVideo")
	if canBePressed:
		canBePressed = false
		if get_tree().get_root().get_children()[2].get_node_or_null("CanvasLayer/BackgroundUnfocus") != null:
			get_tree().get_root().get_children()[2].get_node("CanvasLayer/BackgroundUnfocus").show()
		if get_tree().get_root().get_children()[2].get_node_or_null("CanvasLayer/BackgroundUnfocus") != null:
			get_tree().get_root().get_children()[2].get_node("CanvasLayer/BackgroundUnfocus").color = Color(0,0,0,0.48)
		var loadedMap = map.instance()
		loadedMap.rect_scale = Vector2(0.65, 0.65)
		loadedMap.anchor_left = 0.5
		loadedMap.anchor_right = 0.5
		loadedMap.anchor_top = 0.5
		loadedMap.anchor_bottom = 0.5
		loadedMap.rect_position = Vector2(-loadedMap.rect_size.x/3,-loadedMap.rect_size.y/3)
		loadedMap.setValues()
		get_tree().get_root().get_children()[2].get_node("CanvasLayer").add_child(loadedMap)

func ChangeMapVisibility(isVisible:bool) -> void:
	if isVisible: $CanvasLayer/HBoxContainer.show()
	else: $CanvasLayer/HBoxContainer.hide()

func GetWindowResolution() -> Vector2:
	return get_viewport().size
