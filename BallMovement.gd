extends RigidBody2D

@export var horizontalSpeed = 0;
@export var verticalSpeed = 0;
@export var dir = 1;
var initialHorizontalSpeed = 0;
var initialVerticalSpeed = 0;
var firstCollision = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialHorizontalSpeed = horizontalSpeed
	initialVerticalSpeed = verticalSpeed
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if (firstCollision == false):
		horizontalSpeed = 0
	
	var collision = move_and_collide(Vector2(horizontalSpeed * delta, verticalSpeed * -dir * delta)) 
	
	if(collision):
		firstCollision = true 
		var colliderName = collision.get_collider().name
		
		if (colliderName == "Player"):
			dir = 1
			horizontalSpeed = randi_range(-initialHorizontalSpeed,initialHorizontalSpeed)		
	pass			
