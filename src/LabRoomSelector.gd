extends Node2D

func _on_RoomLabs_pressed() -> void:
	get_tree().change_scene("res://scenes/rooms/Laboratory/Room_LB_LAB.tscn")

func _on_RoomComputerWorkshop_pressed() -> void:
	get_tree().change_scene("res://scenes/rooms/Laboratory/Room_LB_COM-LAB.tscn")

func _on_RoomInternshipsAbroad_pressed() -> void:
	get_tree().change_scene("res://scenes/rooms/Laboratory/Room_LB_MZW.tscn")

func _on_BackButton_pressed() -> void:
	Globals.calledRoomBySelector = Globals.RoomCall.EpisodeSelector
	get_tree().change_scene("res://scenes/EpisodeSelector.tscn")
