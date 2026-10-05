extends RigidBody2D

@export var horizontalSpeed = 0;
@export var verticalSpeed = 0;
@export var dir = 1;
@export var loseScreen = Node;
@export var winScreen = Node;
@onready var losing_sound: AudioStreamPlayer2D = $"../LosingSound"
@onready var win_sound: AudioStreamPlayer2D = $"../WinSounds"
@export var player = Node; 
static var numOfObstalces = 0;
static var numOfBalls = 1;


var initialHorizontalSpeed = 0;
var initialVerticalSpeed = 0;
var firstCollision = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialHorizontalSpeed = horizontalSpeed
	initialVerticalSpeed = verticalSpeed
	
	
func addObstalce():
	numOfObstalces =+ 1 
	print(numOfObstalces)

func _exit_tree():
	numOfObstalces = 0;
	numOfBalls = 0;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (firstCollision == false):
		horizontalSpeed = 0
	
	var collision = move_and_collide(Vector2(horizontalSpeed * delta, verticalSpeed * -dir * delta)) 
	var playerDir = Input.get_axis("ui_left","ui_right")
	
	if(collision):
		firstCollision = true 
		var colliderName = collision.get_collider().name
		print(colliderName)
		
		if (colliderName.contains("Obstacle")):
			numOfObstalces =- 1 
			collision.get_collider().queue_free()
			dir = -1
			horizontalSpeed = randi_range(-initialHorizontalSpeed,initialHorizontalSpeed)
			verticalSpeed = randi_range(initialVerticalSpeed / 1.3, verticalSpeed * 2)
			if (numOfObstalces <= 0):
				win_sound.play();
				winScreen.show();
				player.changePlayerState()
		
		if (colliderName.contains("PowerUp")):
			var ballCopy = duplicate()
			get_tree().current_scene.add_child(ballCopy)
			
			numOfObstalces =- 1 
			collision.get_collider().queue_free()
			dir = -1
			horizontalSpeed = randi_range(-initialHorizontalSpeed,initialHorizontalSpeed)
			verticalSpeed = randi_range(initialVerticalSpeed / 1.3, verticalSpeed * 2)
			if (numOfObstalces <= 0):
				winScreen.show();
				player.changePlayerState()	
			
		
		if (colliderName == "Player"):
			dir = 1
			horizontalSpeed = abs(horizontalSpeed) * playerDir
			
		if (colliderName == "TopWall"):
			dir = -1
			horizontalSpeed = randi_range(-initialHorizontalSpeed,initialHorizontalSpeed)
			verticalSpeed = randi_range(initialVerticalSpeed / 1.3, verticalSpeed * 2)
				
		
		if (colliderName == "LoseHitbox" && numOfObstalces > 0):
			self.queue_free()
			numOfBalls =- 1 
			if (numOfBalls < 1):
				loseScreen.show()
				losing_sound.play()
				player.changePlayerState()
		
		if (colliderName == "LeftWall"):
			dir = -1
			horizontalSpeed = randi_range(initialHorizontalSpeed / 1.3,initialHorizontalSpeed)
			verticalSpeed = randi_range(initialVerticalSpeed / 1.3, initialVerticalSpeed * 2)	
		
		if (colliderName == "RightWall"):
			dir = -1
			horizontalSpeed = randi_range(-initialHorizontalSpeed / 1.3,-initialHorizontalSpeed)
			verticalSpeed = randi_range(initialVerticalSpeed / 1.3, initialVerticalSpeed * 2)	
				
