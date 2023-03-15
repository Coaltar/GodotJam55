extends Sprite


signal start_dialogue
export var dialgoue_key = ""

func _ready():
	pass





func _on_Actionable_actioned():
	var dialogue_key = "Rock"
	SignalBus.emit_signal("display_dialogue", dialgoue_key)
	pass
