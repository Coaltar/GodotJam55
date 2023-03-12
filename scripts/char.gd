extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const speed = 100
const interaction_distance = 50


var attempt_interaction = false

var facing = Vector2.DOWN
var nearest_interactable = null
signal get_interaction

signal nearest_interactable_changed

# Called when the node enters the scene tree for the first time.
func _ready():
	$Indicator.hide()
	
	pass # Replace with function body.

func _process(delta):	
	if(Input.is_action_just_pressed("interact")):
		attempt_interaction()
	if(Input.is_action_just_pressed("cancel")):
		print("cancel")
		
	check_for_interactables()


func _physics_process(delta):
	var direction = Vector2.ZERO
	if(Input.is_action_pressed("move_up")):
		$AnimatedSprite.animation = "walk_up"
		direction.y -= 1
	if(Input.is_action_pressed("move_down")):
		$AnimatedSprite.animation = "walk_down"
		direction.y += 1
	if(Input.is_action_pressed("move_left")):
		$AnimatedSprite.animation = "walk_left"
		direction.x -= 1
	if(Input.is_action_pressed("move_right")):
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
	var areas = $InteractableFinder.get_overlapping_areas()
	var shortest_distance: float = INF
	var next_nearest_interactable: Interactable = null
	
	for area in areas:
		var distance = area.global_position.distance_to(self.global_position)
		if distance < shortest_distance:
			shortest_distance = distance
			next_nearest_interactable = area
	print(shortest_distance)
	
	if next_nearest_interactable != self.nearest_interactable or not is_instance_valid(next_nearest_interactable):
		self.nearest_interactable = next_nearest_interactable
		emit_signal("nearest_interactable_changed", self.nearest_interactable)
	

		
func attempt_interaction():
	pass


func _on_Char_nearest_interactable_changed():
	pass # Replace with function body.
