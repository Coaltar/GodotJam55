extends Control


signal start_game(settings)




func _ready():
	#self.hide()
	SignalBus.connect("start_fishing", self, "on_start_fishing")
	pass

func on_start_fishing(fish_type):
	self.show()
	print("LET'S GO FISHING")
	emit_signal("start_game", "restart_game_signal")


func _on_FishingMinigame_win_game():
	print("win_games")
	self.hide()
	pass # Replace with function body.
