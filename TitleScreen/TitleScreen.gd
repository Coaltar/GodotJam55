extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var selection = 0
var menu_size = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$MenuMusic.play()
	
	update_selector(selection)
	pass # Replace with function body.

func _process(delta):
	if(Input.is_action_just_pressed("move_down")):
		selection += 1 
		selection %= menu_size
		$MenuSound.play()
	elif(Input.is_action_just_pressed("move_up")):
		$MenuSound.play()
		selection += -1
		selection %= menu_size
	elif(Input.is_action_just_pressed("interact")):
		if(selection == 0):
			#start game
			get_tree().change_scene("res://Levels/DebugRoom/DebugRoom.tscn")
		if(selection == 2):
			get_tree().quit()
			#end game
	update_selector(selection)

#for _i in self.get_children():
#    print(_i)
	
func update_selector(index):
	
	var position_nodes = $MenuPlacements.get_children()
	#print(position_nodes)
	$Selector.base_pos = position_nodes[index].global_position
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

