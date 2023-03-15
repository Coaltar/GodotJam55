extends TextureRect

var fishPositionX = 5;
var fishPosition = 80;
var fishPositionMin = 5;
var fishPositionMax = 80;

var aggression = 0;
var deltaAccumulator = 0;
var updateShake = 0.05;
var shakeOffsetX = 0;
var shakeOffsetY = 0;
var random = RandomNumberGenerator.new();

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fishPosition = clamp(fishPosition, fishPositionMin, fishPositionMax);
	deltaAccumulator += delta;
	if(deltaAccumulator > updateShake):
		shakeOffsetX = 1 - random.randf() * 2;
		shakeOffsetY = 1 - random.randf() * 2;
		deltaAccumulator = 0;
	$".".rect_position.y = fishPosition + shakeOffsetY;
	$".".rect_position.x = fishPositionX + shakeOffsetX;
	pass

func GetIsFishInBar(var barMin, var barMax):
	return fishPosition + ($".".rect_size.y / 2)  > barMin && fishPosition + ($".".rect_size.y / 2) < barMax;

func SetAggression(var aggression):
	self.aggression = aggression;
