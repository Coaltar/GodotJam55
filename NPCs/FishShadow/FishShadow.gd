extends Node


signal start_fishing
export var fish_type = ""
export var fish_id = 0

func _ready():
	SignalBus.connect("win_game", self, "on_win_game")

func _on_ActionableNode_actioned():
	SignalBus.emit_signal("start_fishing", fish_id)
	print("Start fishing")
	pass # Replace with function body.


func on_win_game(fish_id):
	print(fish_id)
	print("wingame")
	if(self.fish_id == fish_id):

		self.queue_free()
