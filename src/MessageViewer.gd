extends ScrollContainer

var gotNewMessage := false

func _draw() -> void:
	if gotNewMessage: 
		scroll_vertical = get_v_scrollbar().max_value
		gotNewMessage = false
