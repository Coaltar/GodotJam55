extends TextureRect

var fishPositionX = 5;
var fishPosition = 80;
var fishPositionMin = 5;
var fishPositionMax = 80;

var aggression = 1;
var deltaAccumulator = 0;
var updateShake = 0.05;
var shakeOffsetX = 0;
var shakeOffsetY = 0;
var random = RandomNumberGenerator.new();

var currentFishTargetPosition = 0;
var currentFishSpeed = 0.5;
var currentMaxFishSpeed = 2;
var currentFishAcceleration = 0.25;
var positionTolerance = 0.2;
var retargetAccumulator = 0;
var retargetTime = 2;

var fishState = FishState.Waiting;

enum FishState {
	Waiting,
	Moving
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fishPosition = clamp(fishPosition, fishPositionMin, fishPositionMax);
	
	if(fishState == FishState.Waiting):
		retargetAccumulator += delta;
		if(retargetAccumulator > retargetTime):
			#retarget position and switch state
			fishState = FishState.Moving
			currentMaxFishSpeed = random.randf() * 2 * max(aggression, 0.1) + 0.2;
			currentFishAcceleration = random.randf() * 0.3 * max(aggression,0.1) + 0.2;
			currentFishTargetPosition = (random.randf() * (fishPositionMax - fishPositionMin)) + fishPositionMin; 
	if(fishState == FishState.Moving):
		#move fish
		if(fishPosition < currentFishTargetPosition):
			currentFishSpeed += currentFishAcceleration;
		if(fishPosition > currentFishTargetPosition):
			currentFishSpeed -= currentFishAcceleration;
		currentFishSpeed = clamp(currentFishSpeed, -currentMaxFishSpeed, currentMaxFishSpeed);
		
		#damp fish to prevent dancing :D
		if((fishPosition + currentFishSpeed) * (fishPosition - currentFishTargetPosition) < 0):
			currentFishSpeed *= 0.5;
		
		fishPosition += currentFishSpeed;
		if(abs(fishPosition - currentFishTargetPosition) < positionTolerance):
			#set fish to wait for a random amount of time (scaled by aggression)
			fishState = FishState.Waiting;
			retargetTime = random.randf() / max(aggression,0.1);
			retargetAccumulator = 0;
	
	deltaAccumulator += delta;
	if(deltaAccumulator > updateShake):
		shakeOffsetX = 1 - random.randf() * 2;
		shakeOffsetY = 1 - random.randf() * 2;
		deltaAccumulator = 0;
	$".".rect_position.y = fishPosition + shakeOffsetY;
	$".".rect_position.x = fishPositionX + shakeOffsetX;

func GetIsFishInBar(var barMin, var barMax):
	return fishPosition + ($".".rect_size.y / 2)  > barMin && fishPosition + ($".".rect_size.y / 2) < barMax;

func SetAggression(var aggression):
	self.aggression = aggression;
