extends Label

var labelHeight := 0

func _draw() -> void:
	labelHeight = rect_size.y
	get_parent().get_parent().ResizeBubble()
