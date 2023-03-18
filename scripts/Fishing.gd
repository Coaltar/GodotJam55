extends Node


var fishingProgress = 10;
var fishingBarPosition = 0;
var fishingBarSize = 16;

var minProgressBarSize = 8;
var fishingGrow = 0.25;
var fishingDecay = 0.175;
var failProgress = 0;
var progressStartPosition = 92;
var startingProgress = 10;
var caughtProgress = 88;
var fishingState = FishingState.Fishing;
var fishingBarDeltaAccumulator = 0;
var fishingBarAccumulate = 0.25;

var barMin = 92;
var barMax = 4;

var fishingBarSpeed = 0;
var fishingBarInstantAcceleration = 0;

var fishingBarAcceleration = 0.2;
var fishingBarMaxSpeed = 3;

# Called when the node enters the scene tree for the first time.
func _ready():
	$FishingBar.rect_size.y = fishingBarSize;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if(fishingState == FishingState.Fishing):
		fishingBarDeltaAccumulator += delta;
		if(Input.is_key_pressed(KEY_SPACE) && fishingBarDeltaAccumulator > 0.25):
			fishingBarInstantAcceleration = -fishingBarAcceleration;
		elif(fishingBarDeltaAccumulator > 0.25):
			fishingBarInstantAcceleration = fishingBarAcceleration;
		
		fishingBarSpeed += fishingBarInstantAcceleration;
		fishingBarSpeed = clamp(fishingBarSpeed, -fishingBarMaxSpeed, fishingBarMaxSpeed);
		fishingBarPosition += fishingBarSpeed;
		
		if(fishingBarPosition <= barMax ||
			fishingBarPosition >= barMin - fishingBarSize):
			fishingBarSpeed = -0.5 * fishingBarSpeed;
		
		fishingBarPosition = clamp(fishingBarPosition, barMax, barMin - fishingBarSize);
		fishingProgress = clamp(fishingProgress, failProgress, caughtProgress);
		
		if($FishingBlahaj.GetIsFishInBar(fishingBarPosition, fishingBarPosition + fishingBarSize)):
			fishingProgress += fishingGrow;
		else:
			fishingProgress -= fishingDecay;
		
		if(fishingProgress <= failProgress):
			fishingState = FishingState.Failed;
		if(fishingProgress >= caughtProgress):
			fishingState = FishingState.Caught;
			
		$FishingProgress.rect_size.y = floor(max(fishingProgress, minProgressBarSize));
		$FishingProgress.rect_position.y =  progressStartPosition - $FishingProgress.rect_size.y;
		$FishingBar.rect_position.y = fishingBarPosition;


enum FishingState {
	Fishing,
	Caught,
	Failed
}

func GetFishingStatus():
	return fishingState;

func SetBarSize(var barSize):
	self.fishingBarSize = barSize;
	$FishingBar.rect_size.y = barSize;

func SetFishingRod(var fishingRod):
	self.fishingBarSize = fishingRod.barSize;
	self.fishingBarAcceleration = fishingRod.barAcceleration;
	self.fishingBarMaxSpeed = fishingRod.barMaxSpeed;
