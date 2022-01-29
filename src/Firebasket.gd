extends ColorRect

var somethingOpen := false
var justClosed := false

func _on_OpenAngleGrinder_released() -> void: 
	if justClosed: 
		justClosed = false
		return
	if !somethingOpen:
		$AngleGrinderPU.show()
		Globals.showVideo("Videos/Winkelschleifer.webm", 296, 340, 436, 252, "true", "true", "FirebasketSoundsVideoInfo", "webm")
		somethingOpen = true

func _on_OpenFireBasket_released() -> void: 
	if justClosed: 
		justClosed = false
		return
	if !somethingOpen:
		$WeldingPU.show()
		Globals.showVideo("Videos/Schweissen.webm", 296, 340, 436, 252, "true", "true", "FirebasketSoundsVideoInfo", "webm")
		somethingOpen = true

func _on_OpenSmithing_released() -> void: 
	if justClosed: 
		justClosed = false
		return
	if !somethingOpen:
		$SmithingPU.show()
		Globals.showVideo("Videos/Schmieden.webm", 506, 159, 489, 283, "true", "true", "FirebasketSoundsVideoInfo", "webm")
		somethingOpen = true

func _on_SkipButton2_released() -> void:
	Globals.removeElement("FirebasketSoundsVideoInfo")
	$AngleGrinderPU.hide()
	$WeldingPU.hide()
	$SmithingPU.hide()
	somethingOpen = false
	justClosed = true
