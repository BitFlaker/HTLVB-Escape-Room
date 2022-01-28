extends Node2D

func _ready() -> void:
	$MenuOptionsMenu/Quality.add_item(" gering", 0)
	$MenuOptionsMenu/Quality.add_item(" mittel", 1)
	$MenuOptionsMenu/Quality.add_item(" hoch", 2)
	$MenuOptionsMenu/Quality.selected = 0

func starGameLoadScene() -> void:
	Globals.settingsVolume = int($MenuOptionsMenu/SoundLevel.text)
	Globals.settingsMusic = int($MenuOptionsMenu/MusicLevel.text)
	Globals.settingsSFX = int($MenuOptionsMenu/SFXLevel.text)
	Globals.mediaQuality = Globals.MediaQuality.values()[$MenuOptionsMenu/Quality.selected]
	get_tree().change_scene("res://GameBeginning.tscn")

func _on_startGame_released() -> void:
	$AudioStreamPlayer2D.play()
	$AnimationPlayer.play("startGameAnim")

func _on_options_released() -> void:
	$AudioStreamPlayer2D.play()
	$AnimationPlayer.play("GetToOptionsMenu")

func _on_Quality_item_selected(index: int) -> void:
	$AudioStreamPlayer2D.play()
	if index == 0:
		$CanvasLayer/DialogBox/Content.text = "Bei geriner Qualität werden Videos im Spiel mit geringer Auflösung und Qualität gezeigt. Die Internetbelastung ist hierbei am geringsten."
		$CanvasLayer/DialogBox.show()
	elif index == 2:
		$CanvasLayer/DialogBox/Content.text = "Bei hoher Qualität werden Videos im Spiel mit der besten Auflösung und Qualität gezeigt. Die Internetbelastung ist hierbei am höchsten."
		$CanvasLayer/DialogBox.show()

func _on_DialogOkButton_released() -> void:
	$CanvasLayer/DialogBox.hide()
	$AudioStreamPlayer2D.play()
