extends ColorRect

var startTime := 0
var hasReleased := false

func _ready() -> void:
	startTime = OS.get_ticks_msec() / 1000

func _input(event: InputEvent) -> void:
	if visible and event is InputEventMouseButton:
		if event.pressed == false:
			hasReleased = true

func _on_TextureButton_button_down() -> void:
	if hasReleased and !$AnimationPlayer2.is_playing():
		$AnimationPlayer2.play("disappear")
