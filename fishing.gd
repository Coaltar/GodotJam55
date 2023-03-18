extends Node


var fishingProgress = 10;
var fishingBarPosition = 0;
var fishingBarSize = 8;

var fishingGrow = 1;
var fishingDecay = 1;


var progressStartPosition = 92;


var fishingState = FishingState.Fishing;
var fishingBarDeltaAccumulator = 0;
var fishingBarAccumulate = 0.25;



var startingProgress = 10; #intial value for progress bar
#bounds for progress bar
var failProgress = 8;
var caughtProgress = 88;

#min and max values for fishing bar
var barMin = 92;
var barMax = 4;


signal win_game

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_process(false)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(fishingState == FishingState.Fishing):
		fishingBarDeltaAccumulator += delta;
		if(Input.is_key_pressed(KEY_SPACE) && fishingBarDeltaAccumulator > 0.25):
			fishingBarPosition -= 1;
		elif(fishingBarDeltaAccumulator > 0.25):
			fishingBarPosition += 1;
			
		fishingBarPosition = clamp(fishingBarPosition, barMax, barMin - fishingBarSize);
		fishingProgress = clamp(fishingProgress, failProgress, caughtProgress);
		
		
		if($FishingBlahaj.GetIsFishInBar(fishingBarPosition, fishingBarPosition + fishingBarSize)):
			fishingProgress += fishingGrow;
		else:
			fishingProgress -= fishingDecay;
		

		if(fishingProgress >= caughtProgress):
			self.win_game()
			
		
		
		#if(fishingProgress <= failProgress):
		#	fishingState = FishingState.Failed;
		#if(fishingProgress >= caughtProgress):
		#	fishingState = FishingState.Caught;
		$FishingProgress.rect_size.y = fishingProgress;
		$FishingProgress.rect_position.y = progressStartPosition - fishingProgress;
		$FishingBar.rect_position.y = fishingBarPosition;


enum FishingState {
	Fishing,
	Caught,
	Failed
}

func FishingStatus():
	return fishingState;

func SetBarSize(var barSize):
	self.fishingBarSize = barSize;


func win_game():
	self.set_process(false)
	emit_signal("win_game")
	

func _on_FishingWindow_start_game(settings):
	print(settings)
	self.set_process(true)
	self.fishingProgress = startingProgress
	pass # Replace with function body.
