extends Node


signal start_fishing
export var fish_type = ""


func _on_ActionableNode_actioned():
	SignalBus.emit_signal("start_fishing", fish_type)
	print("Start fishing")
	pass # Replace with function body.
