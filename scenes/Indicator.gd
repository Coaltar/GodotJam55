extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Lily_nearest_interactable_changed(nearest_interactable):
	if(nearest_interactable != null):
		self.show()
	else:
		self.hide()
	pass # Replace with function body.
