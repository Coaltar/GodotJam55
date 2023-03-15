extends Sprite


signal start_dialogue
export var dialgoue_key = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass





func _on_Actionable_actioned():

	print("Rock action + dialogue")
	var dialogue_key = "Rock"
	print("Dialgoue Key: " + dialgoue_key)
	SignalBus.emit_signal("display_dialogue", dialgoue_key)
	pass # Replace with function body.
