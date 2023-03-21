extends Control


signal start_game(settings)




func _ready():
	
	self.hide()
	SignalBus.connect("start_fishing", self, "on_start_fishing")
	pass

func on_start_fishing(fish_type):
	self.show()
	print("LET'S GO FISHING")
	emit_signal("start_game", fish_type)


func _on_FishingMinigame_win_game(fish_id):
	print("asfdasdf")
	SignalBus.emit_signal("win_game", fish_id)
	self.hide()
	
	pass # Replace with function body.
