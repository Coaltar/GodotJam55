extends Node

var fishingThrow = 0;
var fishingThrowBarMinSize = 8;
var fishingThrowBarMaxSize = 58;
var fishingThrowDirection = 1;
var fishingThrowSpeed = 1;

var fishingThrowState = ThrowState.Throwing;

enum ThrowState {
	Throwing,
	Thrown
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if(!Input.is_action_pressed("fishing_throw_hold")):
		fishingThrowState = ThrowState.Thrown;
	if(fishingThrowState == ThrowState.Throwing):
		fishingThrow += fishingThrowDirection * fishingThrowSpeed;
		if(fishingThrow >= fishingThrowBarMaxSize ||
			fishingThrow <= 0):
			fishingThrowDirection *= -1;
		$FishingThrow.rect_size.x = max(fishingThrowBarMinSize, fishingThrow);

func IsDone():
	return fishingThrowState == ThrowState.Thrown;
	
func GetThrowStrength():
	return fishingThrow;
