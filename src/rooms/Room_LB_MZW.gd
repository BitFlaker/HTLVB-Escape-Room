extends Node2D

var canClick := true
var previousSlide := 1
var currentSlide := 1
var totalSlides := 4
var dragging := false
var isInSlideshow := false
var isSliding := false
var xDiff := 0.0
var tutorialShown := false
var _globals
const numSeq := ["4", "3", "1", "2"]
var showingNum := false
var isInVerein := false
var isInEuropa := false
var isInQuizMap := false

func _ready() -> void:
	_globals = get_tree().get_root().get_node("Globals")
	$CanvasLayer/Number.text = str(_globals.CODE_MZW)
	Globals.currentRoom = Globals.Rooms.MZW

func _process(delta: float) -> void:
	if $CanvasLayer3/Slides.visible:
		if $MZW_Background/ShowInfos.visible:
			for c in $MZW_Background.get_children():
				c.hide()
	else:
		if !$MZW_Background/ShowInfos.visible:
			for c in $MZW_Background.get_children():
				c.show()

func _on_LogoPress_released() -> void:
	if !isInSlideshow: 
		$ColorRect.rect_position = $MZW_Background/Logo_MZW/LogoPress.get_global_transform().get_origin()
		$ColorRect.rect_size = ($MZW_Background/Logo_MZW/LogoPress.scale * Vector2(800, 600))*Vector2(0.784,0.784)*Vector2(0.253,0.253)
		$Camera2D.zoom_in(($ColorRect.rect_position + ($ColorRect.rect_size / Vector2(2,2))) - $Camera2D.get_camera_position())

func _input(event: InputEvent) -> void:
	if !showingNum:
		if event is InputEventMouseButton and event.button_index == 1 and event.pressed == false and $Camera2D.current_zoom == Vector2($Camera2D.zoom_factor,$Camera2D.zoom_factor):
			var evLocal = make_input_local(event)
			if !$ColorRect.get_rect().has_point(evLocal.position):
				zoomReset()

func zoomReset() -> void:
	if canClick: 
		$Camera2D.zoom_out(Vector2(512,300))
		$Camera2D.zoom_factor = 0.25
		$Camera2D.reload()

func _on_SlideshowPress_released() -> void:
	if !showingNum:
		$CanvasLayer3/Slides.show()
		$CanvasLayer3/Slides/EuropeCardFillIn.show()

func zoomToSlideShow() -> void:
	$ColorRect.rect_position = $MZW_Background/SlideshowPress.get_global_transform().get_origin()
	$ColorRect.rect_size = ($MZW_Background/SlideshowPress.scale * Vector2(800, 600))*Vector2(0.784,0.784)
	$Camera2D.zoom_in(($ColorRect.rect_position + ($ColorRect.rect_size / Vector2(2,2))) - $Camera2D.get_camera_position())

func instantZoomOut() -> void:
	$Camera2D.zoom = Vector2(1,1)
	$Camera2D.offset = Vector2(512,300)

func isDone() -> void:
	if( $CanvasLayer3/Slides/EuropeCardFillIn/fill1.text == numSeq[0] and
		$CanvasLayer3/Slides/EuropeCardFillIn/fill2.text == numSeq[1] and
		$CanvasLayer3/Slides/EuropeCardFillIn/fill3.text == numSeq[2] and
		$CanvasLayer3/Slides/EuropeCardFillIn/fill4.text == numSeq[3] 
		) and !showingNum:
			DisableAllButtons()
			$AnimationPlayer.play("ShowNumber")

func DisableAllButtons() -> void:
	$MZW_Background/Logo_MZW/LogoPress.hide()
	$MZW_Background/SlideshowPress.hide()
	$MZW_Background/ShowInfos.hide()
	showingNum = true

func _on_fill1_text_changed(_new_text: String) -> void: isDone()
func _on_fill2_text_changed(_new_text: String) -> void: isDone()
func _on_fill3_text_changed(_new_text: String) -> void: isDone()
func _on_fill4_text_changed(_new_text: String) -> void: isDone()

func _on_BackButton_released() -> void:
	if $CanvasLayer3/Slides.visible:
		if isInEuropa or isInVerein:
			$CanvasLayer3/Slides/Verein.hide()
			$CanvasLayer3/Slides/Europa.hide()
			isInEuropa = false
			isInVerein = false
			$CanvasLayer3/Slides/Selection.show()
		elif $CanvasLayer3/Slides/Quiz.visible:
			$CanvasLayer3/Slides/Quiz.hide()
			$CanvasLayer3/Slides/EuropeCardFillIn.show()
		else:
			for c in $CanvasLayer3/Slides.get_children(): if c.visible: c.hide()
			$CanvasLayer3/Slides.hide()
			isInSlideshow = false
	else:
		get_tree().change_scene("res://scenes/rooms/Laboratory/Building_Laboratory.tscn")

func _on_CheckEnteredRow_released() -> void: isDone()

func _on_ShowInfos_released() -> void:
	if !showingNum:
		$CanvasLayer3/Slides.show()
		$CanvasLayer3/Slides/Selection.show()

func _on_SelectionVerein_pressed() -> void:
	$CanvasLayer3/Slides/Selection.hide()
	$CanvasLayer3/Slides/Verein.show()
	isInVerein = true

func _on_SelectionEuropa_pressed() -> void:
	$CanvasLayer3/Slides/Selection.hide()
	$CanvasLayer3/Slides/Europa.show()
	isInEuropa = true

func _on_TextureButton_pressed() -> void:
	$CanvasLayer3/Slides/EuropeCardFillIn.hide()
	$CanvasLayer3/Slides/Quiz.show()
