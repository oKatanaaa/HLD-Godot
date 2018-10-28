extends KinematicBody2D

const SPEED = 100

func _ready():
	$DrifterImg.play("idle right")
	pass

func _physics_process(delta):
	var input_x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	var input_y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	
	if input_x != 0 or input_y != 0:
		var direction_final = Vector2(input_x, input_y)
		change_sprite(input_x, input_y)
		
		direction_final = direction_final.normalized() * SPEED
		move_and_slide(direction_final)
	else:
		$DrifterImg.frame = 0
		$DrifterImg.play("idle right")
		
	pass

func change_sprite(input_x, input_y):
	if input_y == -1:
		$DrifterImg.play("run up")
		return
		
	if input_y == 1:
		$DrifterImg.play("run down")
		return
		
	if input_x != 0:
		$DrifterImg.play("run right")
		$DrifterImg.flip_h = (input_x == -1)
		return
	
	
	pass