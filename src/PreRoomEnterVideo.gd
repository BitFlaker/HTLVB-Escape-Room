extends Node2D

var videoURL := ""
var finishRoomEnterPath := ""
var startedVideo := false

func start() -> void:
	var splitPath = videoURL.split(".")
	var extension = splitPath[splitPath.size() - 1]
	Globals.showVideo(videoURL, 0, 0, 1024, 551, "true", "true", "PRE_ROOM_VIDEO", extension)
	startedVideo = true
	ZZInGameUi.pause(true)

func _process(_delta: float) -> void:
	if startedVideo and !Globals.idExists("PRE_ROOM_VIDEO"):
		startedVideo = false
		get_tree().change_scene(finishRoomEnterPath)
		ZZInGameUi.resume()

func _on_SkipButton_released() -> void:
	Globals.removeElement("PRE_ROOM_VIDEO")
	get_tree().change_scene(finishRoomEnterPath)
	ZZInGameUi.resume()
