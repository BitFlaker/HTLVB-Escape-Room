extends Node2D

var startedVideo := false

func _ready() -> void:
	Globals.showVideo("Videos/Anfang.webm", 0, 0, 1024, 551, "false", "true", "StartVideoIntro", "webm")
	startedVideo = true

func _process(_delta: float) -> void:
	if startedVideo and !Globals.idExists("StartVideoIntro"):
		startedVideo = false
		get_tree().change_scene("res://scenes/rooms/Theory/Room_TH_CAD.tscn")

func _on_SkipButton_released() -> void:
	Globals.removeElement("StartVideoIntro")
	get_tree().change_scene("res://scenes/rooms/Theory/Room_TH_CAD.tscn")
