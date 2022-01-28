extends ColorRect

var isHoldingToothbrush := false
var xDiff := 0.0
var yDiff := 0.0
var toothbrushTimeout := 2
var startTime := 0

func _ready() -> void:
	$Label.text = str(Globals.CODE_CL5)

func _process(_delta: float) -> void:
	if isHoldingToothbrush:
		var pos = get_viewport().get_mouse_position()
		$Toothbrush.position.x = pos.x - xDiff
		$Toothbrush.position.y = pos.y - yDiff
	if startTime > 0 and OS.get_ticks_msec() - startTime > 6000:
		set_process(false)
		$AnimationPlayer.play("showSpongeNumber")

func _on_Toothbrush_pressed() -> void:
	var clickPos = get_viewport().get_mouse_position()
	var curPos = $Toothbrush.position
	xDiff = clickPos.x - curPos.x
	yDiff = clickPos.y - curPos.y
	isHoldingToothbrush = true

func _on_Toothbrush_released() -> void:
	isHoldingToothbrush = false

func _on_ToothArea_area_exited(area: Area2D) -> void:
	if "ToothbrushArea" in area.name:
		if $AutomationSponge/ToothbrushParticles.emitting == false:
			$AutomationSponge/ToothbrushParticles.emitting = true
			startTime = OS.get_ticks_msec()
		$Timer.stop()
		$Timer.start(toothbrushTimeout)

func _on_Timer_timeout() -> void:
	$AutomationSponge/ToothbrushParticles.emitting = false
	startTime = 0
