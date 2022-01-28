extends CanvasLayer

func _ready() -> void:
	$ColorRect.hide()

func StartTransition() -> void:
	$ColorRect.show()
	$AnimationPlayer.play("Transition")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if $ColorRect.visible == true:
		Globals.changeSceneToSelector()
		$AnimationPlayer.play("TransitionBack")
