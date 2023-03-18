extends Node2D


signal start_dialogue
export var dialgoue_key = ""



func _on_ActionableNode_actioned():
	SignalBus.emit_signal("display_dialogue", dialgoue_key)
	pass # Replace with function body.
