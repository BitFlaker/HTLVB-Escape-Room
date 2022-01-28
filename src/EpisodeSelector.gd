extends Node2D

func _on_EpisodesTheory_pressed() -> void:
	Globals.calledRoomBySelector = Globals.RoomCall.TheoryRoomSelector
	get_tree().change_scene("res://scenes/TheoryRoomSelector.tscn")

func _on_EpisodesLab_pressed() -> void:
	Globals.calledRoomBySelector = Globals.RoomCall.LabRoomSelector
	get_tree().change_scene("res://scenes/LabRoomSelector.tscn")

func _on_EpisodesWorkshop_pressed() -> void:
	get_tree().change_scene("res://scenes/rooms/Workshop/Building_Workshop.tscn")

func _on_BackButton_pressed() -> void:
	Globals.calledRoomBySelector = Globals.RoomCall.None
	get_tree().change_scene("res://MainMenu.tscn")
