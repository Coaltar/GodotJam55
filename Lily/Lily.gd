extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const speed = 100
const interaction_distance = 50
var facing = Vector2.DOWN


#var attempt_interaction = false



var nearest_actionable = null
signal actioned
signal nearest_actionable_changed(nearest_actionable)

func _ready():
	$Indicator.hide()
	pass

func _process(delta):	
	if(Input.is_action_just_pressed("interact")):
		attempt_interaction()
	if(Input.is_action_just_pressed("cancel")):
		print("cancel")
		
	check_for_interactables()

func _unhandled_input(event):
	if(event.is_action_pressed("interact")):
		get_viewport().set_input_as_handled()
		if(is_instance_valid(self.nearest_actionable)):
			self.nearest_actionable.emit_signal("actioned")
			print(self.nearest_actionable)

func _physics_process(delta):
	#todo:
	#do we want 8 direction or four direction movement??
	var direction = Vector2.ZERO
	if(Input.is_action_pressed("move_up")):
		$AnimatedSprite.animation = "walk_up"
		direction.y -= 1
	elif(Input.is_action_pressed("move_down")):
		$AnimatedSprite.animation = "walk_down"
		direction.y += 1
	elif(Input.is_action_pressed("move_left")):
		$AnimatedSprite.animation = "walk_left"
		direction.x -= 1
	elif(Input.is_action_pressed("move_right")):
		$AnimatedSprite.animation = "walk_right"
		direction.x += 1
	if(direction.length() > 0):
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
			
		
	direction = direction.normalized() 
	
	
	
	if(Input.is_action_just_pressed("interact")):
		print("interact")
	if(Input.is_action_just_pressed("cancel")):
		print("cancel")
	
	var velocity = speed * direction
	move_and_slide(velocity, direction)
	
	self.set_facing(direction)
	#print(self.facing)
	
	#look_for_interactable()
	pass
	
func set_facing(direction):
	if(direction.y > 0):
		self.facing = Vector2.DOWN
	if(direction.y < 0):
		self.facing = Vector2.UP
	if(direction.x > 0):
		self.facing = Vector2.RIGHT
	if(direction.x < 0):
		self.facing = Vector2.LEFT
	
	
func check_for_interactables():
	var areas = $actionable_finder.get_overlapping_areas()
	var shortest_distance: float = INF
	var next_nearest_actionable: Actionable = null
	
	for area in areas:
		var distance = area.global_position.distance_to(self.global_position)
		if distance < shortest_distance:
			shortest_distance = distance
			next_nearest_actionable = area
	
	if next_nearest_actionable != self.nearest_actionable or not is_instance_valid(next_nearest_actionable):
		self.nearest_actionable = next_nearest_actionable
		emit_signal("nearest_actionable_changed", self.nearest_actionable)


		
func attempt_interaction():
	pass


func _on_Char_nearest_interactable_changed():
	pass # Replace with function body.

func _on_obstacle_actioned():
	print("AHHH")
	
	
func _on_Rock_actioned():
	print("AHHH")
