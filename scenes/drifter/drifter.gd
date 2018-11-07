extends KinematicBody2D

const SPEED = 6000

var moveDir = Dir.CENTER
var spriteDir = "Down"

func _physics_process(delta):
	controls_loop()
	movement_cycle(delta)
	spriteDir_loop()
	animation_cycle()
	
func movement_cycle(delta):
	var motion = moveDir.normalized() * SPEED * delta
	move_and_slide(motion)
	
func animation_cycle():
	match moveDir:
		Dir.CENTER:
			switch_anim("Idle")
		_:
			switch_anim("Run")
	
func spriteDir_loop():
	match moveDir:
		Dir.LEFT:
			spriteDir = "Left"
		Dir.RIGHT:
			spriteDir = "Right"
		Dir.UP:
			spriteDir = "Up"
		Dir.DOWN:
			spriteDir = "Down"
	
func switch_anim(animation):
	var newAnim = str(animation, spriteDir)
	if $anim.current_animation != newAnim:
		$anim.play(newAnim)
			
	
func controls_loop():
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	
	moveDir.x = -int(LEFT) + int(RIGHT)
	moveDir.y = -int(UP) + int(DOWN)
	

# Receives a "area_entered" signal from hitbox_collision
func collide_with_smth(body):
	if body.TYPE == "hitbox" or true:
		print("get damage")
