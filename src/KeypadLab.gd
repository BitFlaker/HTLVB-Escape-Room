extends Sprite

var enteredCode := ""
var codeToBeEntered := "000"

func _ready() -> void:
	codeToBeEntered = str(Globals.codeLAB[0], Globals.codeLAB[1], Globals.codeLAB[2])

func ShowCode(add:String) -> void:
	if enteredCode.length() >= 10: return
	enteredCode = str(enteredCode, add)
	$Code.text = enteredCode
	if enteredCode == codeToBeEntered:
		Globals.openNewRoomWithVideo("Videos/LabToWS.webm", "res://scenes/rooms/Workshop/Building_Workshop.tscn")

func _on_1_released() -> void: ShowCode("1")
func _on_2_released() -> void: ShowCode("2")
func _on_3_released() -> void: ShowCode("3")
func _on_4_released() -> void: ShowCode("4")
func _on_5_released() -> void: ShowCode("5")
func _on_6_released() -> void: ShowCode("6")
func _on_7_released() -> void: ShowCode("7")
func _on_8_released() -> void: ShowCode("8")
func _on_9_released() -> void: ShowCode("9")
func _on_0_released() -> void: ShowCode("0")

func _on_Star_released() -> void: 
	enteredCode = "" 
	ShowCode("")

func _on_BackButton_released() -> void:
	hide()
	get_parent().get_node("PadBackground").hide()
	get_parent().get_parent().get_node("Clickables").show()
