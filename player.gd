extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var isPlayeAlive = true;

func changePlayerState():
	isPlayeAlive = false

func _physics_process(delta):
	
	if (isPlayeAlive == false):
		return
	
	var dir = Input.get_axis("ui_left","ui_right")
	move_and_collide(Vector2(dir*SPEED*delta,0))
