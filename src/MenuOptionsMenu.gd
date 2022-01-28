extends Sprite

var soundLevel := 100
var musicLevel := 100
var sfxLevel := 100
var soundPressed := false
var musicPressed := false
var sfxPressed := false
var changeVal := 1

func _process(_delta: float) -> void:
	if soundPressed:
		soundLevel = soundLevel + changeVal
		if soundLevel < 0: soundLevel = 0
		if soundLevel > 100: soundLevel = 100
	if musicPressed:
		musicLevel = musicLevel + changeVal
		if musicLevel < 0: musicLevel = 0
		if musicLevel > 100: musicLevel = 100
	if sfxPressed:
		sfxLevel = sfxLevel + changeVal
		if sfxLevel < 0: sfxLevel = 0
		if sfxLevel > 100: sfxLevel = 100
	reloadSounds()

func _on_SoundAdd_released() -> void:
	soundPressed = false
	$SoundTimer.stop()

func _on_SoundRemove_released() -> void:
	soundPressed = false
	$SoundTimer.stop()

func _on_MusicAdd_released() -> void:
	musicPressed = false
	$MusicTimer.stop()

func _on_MusicRemove_released() -> void:
	musicPressed = false
	$MusicTimer.stop()

func _on_SFXAdd_released() -> void:
	sfxPressed = false
	$SFXTimer.stop()

func _on_SFXRemove_released() -> void:
	sfxPressed = false
	$SFXTimer.stop()

func reloadSounds() -> void:
	$SoundLevel.text = str(soundLevel)
	$MusicLevel.text = str(musicLevel)
	$SFXLevel.text = str(sfxLevel)


func _on_SoundAdd_pressed() -> void:
	changeVal = 1
	soundLevel = soundLevel + 1
	if soundLevel > 100: soundLevel = 100
	reloadSounds()
	$SoundTimer.start(0.5)
	get_parent().get_node("AudioStreamPlayer2D").play()

func _on_SoundRemove_pressed() -> void:
	changeVal = -1
	soundLevel = soundLevel - 1
	if soundLevel < 0: soundLevel = 0
	reloadSounds()
	$SoundTimer.start(0.5)
	get_parent().get_node("AudioStreamPlayer2D").play()

func _on_MusicAdd_pressed() -> void:
	changeVal = 1
	musicLevel = musicLevel + 1
	if musicLevel > 100: musicLevel = 100
	reloadSounds()
	$MusicTimer.start(0.5)
	get_parent().get_node("AudioStreamPlayer2D").play()

func _on_MusicRemove_pressed() -> void:
	changeVal = -1
	musicLevel = musicLevel - 1
	if musicLevel < 0: musicLevel = 0
	reloadSounds()
	$MusicTimer.start(0.5)
	get_parent().get_node("AudioStreamPlayer2D").play()

func _on_SFXAdd_pressed() -> void:
	changeVal = 1
	sfxLevel = sfxLevel + 1
	if sfxLevel > 100: sfxLevel = 100
	reloadSounds()
	$SFXTimer.start(0.5)
	get_parent().get_node("AudioStreamPlayer2D").play()

func _on_SFXRemove_pressed() -> void:
	changeVal = -1
	sfxLevel = sfxLevel - 1
	if sfxLevel < 0: sfxLevel = 0
	reloadSounds()
	$SFXTimer.start(0.5)
	get_parent().get_node("AudioStreamPlayer2D").play()

func _on_SoundTimer_timeout() -> void:
	soundPressed = true

func _on_MusicTimer_timeout() -> void:
	musicPressed = true

func _on_SFXTimer_timeout() -> void:
	sfxPressed = true

func _on_Back_released() -> void:
	get_tree().get_root().get_node("MainMenu/AnimationPlayer").play("GetToMainMenu")
