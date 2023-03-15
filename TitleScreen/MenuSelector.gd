extends Control


var base_pos = self.rect_global_position

const bounce = 5
var phase = 0


func _ready():
	$AnimatedSprite.play()
	pass # Replace with function body.

func _process(delta):
	
	phase += delta
	var new_y = base_pos.y + bounce * sin(phase) 
	var new_x = base_pos.x
	self.rect_global_position = Vector2(new_x, new_y)
	pass

	
