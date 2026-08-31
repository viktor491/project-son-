extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta):
	var dir = Input.get_axis("ui_left","ui_right")
	move_and_collide(Vector2(dir*SPEED*delta,0))
