extends ColorRect

var somethingOpen := false
var justClosed := false
var _globals

func _ready() -> void:
	_globals = get_tree().get_root().get_node("Globals")
	# can still click through the quiz to the collection

func _on_OpenAngleGrinder_released() -> void: 
	if justClosed: 
		justClosed = false
		return
	if !somethingOpen:
		$AngleGrinderPU.show()
		_globals.showVideo("Videos/Winkelschleifer.webm", 296, 340, 436, 252, "true", "true", "FirebasketSoundsVideoInfo", "webm")
		somethingOpen = true

func _on_OpenFireBasket_released() -> void: 
	if justClosed: 
		justClosed = false
		return
	if !somethingOpen:
		$WeldingPU.show()
		_globals.showVideo("Videos/Schweissen.webm", 296, 340, 436, 252, "true", "true", "FirebasketSoundsVideoInfo", "webm")
		somethingOpen = true

func _on_OpenSmithing_released() -> void: 
	if justClosed: 
		justClosed = false
		return
	if !somethingOpen:
		$SmithingPU.show()
		_globals.showVideo("Videos/Schmieden.webm", 506, 159, 489, 283, "true", "true", "FirebasketSoundsVideoInfo", "webm")
		somethingOpen = true

func _on_SkipButton2_released() -> void:
	_globals.removeElement("FirebasketSoundsVideoInfo")
	$AngleGrinderPU.hide()
	$WeldingPU.hide()
	$SmithingPU.hide()
	somethingOpen = false
	justClosed = true
