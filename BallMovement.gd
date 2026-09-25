extends RigidBody2D

@export var horizontalSpeed = 0;
@export var verticalSpeed = 0;
@export var dir = 1;
@export var loseScreen = Node;
@export var player = Node; 
var initialHorizontalSpeed = 0;
var initialVerticalSpeed = 0;
var firstCollision = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialHorizontalSpeed = horizontalSpeed
	initialVerticalSpeed = verticalSpeed
	
	


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
			collision.get_collider().queue_free()
			dir = -1
			horizontalSpeed = randi_range(-initialHorizontalSpeed,initialHorizontalSpeed)
			verticalSpeed = randi_range(initialVerticalSpeed / 1.3, verticalSpeed * 2)
			
		
		if (colliderName == "Player"):
			dir = 1
			horizontalSpeed = abs(horizontalSpeed) * playerDir
			
		if (colliderName == "TopWall"):
			dir = -1
			horizontalSpeed = randi_range(-initialHorizontalSpeed,initialHorizontalSpeed)
			verticalSpeed = randi_range(initialVerticalSpeed / 1.3, verticalSpeed * 2)
				
		
		if (colliderName == "LoseHitbox"):
			loseScreen.show()
			self.queue_free()
			player.changePlayerState()
		
		if (colliderName == "LeftWall"):
			dir = -1
			horizontalSpeed = randi_range(initialHorizontalSpeed / 1.3,initialHorizontalSpeed)
			verticalSpeed = randi_range(initialVerticalSpeed / 1.3, initialVerticalSpeed * 2)	
		
		if (colliderName == "RightWall"):
			dir = -1
			horizontalSpeed = randi_range(-initialHorizontalSpeed / 1.3,-initialHorizontalSpeed)
			verticalSpeed = randi_range(initialVerticalSpeed / 1.3, initialVerticalSpeed * 2)	
				
