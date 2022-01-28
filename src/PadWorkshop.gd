extends Sprite

var enteredCode := ""
var codeToBeEntered := "00000"

func _ready() -> void:
	codeToBeEntered = str(Globals.CODE_CL1, Globals.CODE_CL2, Globals.CODE_CL3, Globals.CODE_CL4, Globals.CODE_CL5)

func ShowCode(add:String) -> void:
	if enteredCode.length() >= 10: return
	enteredCode = str(enteredCode, add)
	$Code.text = enteredCode
	if enteredCode == codeToBeEntered:
		Globals.openNewRoomWithVideo("Videos/Ende.webm", "res://scenes/GameEnd.tscn")
		ZZInGameUi.pause(true)
		ZZInGameUi.finished_game()

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
	ZZInGameUi.showAllPrevVisibleTSButtons()
	hide()
	get_parent().get_node("PadBackground2").hide()
	get_parent().get_parent().get_node("WorkshopOverview/ShowAllParts").show()
	get_parent().get_parent().get_node("WorkshopOverview/CodeEnter").show()
