extends Node2D

func _on_RoomCAD_pressed() -> void:
	get_tree().change_scene("res://scenes/rooms/Theory/Room_TH_CAD.tscn")

func _on_RoomClass_pressed() -> void:
	get_tree().change_scene("res://scenes/rooms/Theory/Room_TH_CLASS.tscn")

func _on_RoomAula_pressed() -> void:
	get_tree().change_scene("res://scenes/rooms/Theory/Room_TH_AULA.tscn")

func _on_RoomGym_pressed() -> void:
	get_tree().change_scene("res://scenes/rooms/Theory/Room_TH_GYM.tscn")

func _on_RoomSecretary_pressed() -> void:
	get_tree().change_scene("res://scenes/rooms/Theory/Room_TH_ADMIN.tscn")

func _on_RoomNaturalSciences_pressed() -> void:
	get_tree().change_scene("res://scenes/rooms/Theory/Room_TH_NAWI.tscn")

func _on_BackButton_pressed() -> void:
	Globals.calledRoomBySelector = Globals.RoomCall.EpisodeSelector
	get_tree().change_scene("res://scenes/EpisodeSelector.tscn")
