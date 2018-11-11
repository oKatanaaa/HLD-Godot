extends KinematicBody2D

class MoveStateObject: 
	func _init():
		pass

	static func checkIfAttack():
		return InputEventMouseButton.pressed()
		
class AttackStateObject:
	var isAnimationFinished
	
	func _init():
		self.isAnimationFinished = false
		
	func animationFinished():
		self.isAnimationFinished = true
	
		
const MAX_HEALTH = 5
var health = MAX_HEALTH

const MAX_SPEED = 60.0
var speed = MAX_SPEED

enum State { MOVE, ATTACK, DASH, HITTED }
const STARTING_STATE = State.MOVE
var state = STARTING_STATE

var spriteDirection = "Down"
var moveDirection = Dir.CENTER
var attackDirection = Dir.CENTER

var isAllowedSetAttackDirection = true
var isAllowedSetMoveDirection = true
var isAllowedSetSpriteDirection = true
var isAllowedUpdatePosition = true

var moveStateObject = MoveStateObject.new()
var attackStateObject = AttackStateObject.new()

func _physics_process(delta):
	if isAllowedSetAttackDirection:
		setAttackDirection()
	if isAllowedSetMoveDirection:
		setMoveDirection()
	if isAllowedSetSpriteDirection:
		setSpriteDirection()
	if isAllowedUpdatePosition:
		updatePosition()
	
	changeSprite()
	playStateLogic()
		
func playStateLogic():
	match state:
		State.MOVE:
			moveLogic()
		State.ATTACK:
			attackLogic()
		State.DASH:
			dashLogic()
		State.HITTED:
			hittedLogic()
		_:
			print("UNKNOWN STATE!")

func moveLogic():
	isAllowedSetAttackDirection = true
	isAllowedUpdatePosition = true
	isAllowedSetSpriteDirection = true
	isAllowedSetMoveDirection = true
	
	if Input.is_action_just_pressed("mouse_left_click"):
		state = State.ATTACK
	
func attackLogic():
	if attackStateObject.isAnimationFinished:
		state = State.MOVE

func dashLogic():
	pass
	
func hittedLogic():
	pass

func changeSprite():
	match state:
		State.MOVE:
			if moveDirection == Dir.CENTER:
				switchAnim("Idle")
			else:
				switchAnim("Run")
				
		State.ATTACK:
			switchAnim("Attack")
			
		State.DASH:
			switchAnim("Dash")
			
		State.HITTED:
			switchAnim("Hitted")

func switchAnim(animation):
	var newAnim = str(animation, spriteDirection)
	if $anim.current_animation != newAnim:
		$anim.play(newAnim)

func setSpriteDirection():
	match moveDirection:
		Dir.LEFT:
			spriteDirection = "Left"
		Dir.RIGHT:
			spriteDirection = "Right"
		Dir.DOWN:
			spriteDirection = "Down"
		Dir.UP:
			spriteDirection = "Up"

func setMoveDirection():
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	
	moveDirection.x = -int(LEFT) + int(RIGHT)
	moveDirection.y = -int(UP) + int(DOWN)
	
func setAttackDirection():
	pass
	
func updatePosition():
	var motion = moveDirection.normalized() * speed
	move_and_slide(motion)






















#const SPEED = 6000
#
#var moveDir = Dir.CENTER
#var spriteDir = "Down"
#
#func _physics_process(delta):
#	controls_loop()
#	movement_cycle(delta)
#	spriteDir_loop()
#	animation_cycle()
#
#func movement_cycle(delta):
#	var motion = moveDir.normalized() * SPEED * delta
#	move_and_slide(motion)
#
#func animation_cycle():
#	match moveDir:
#		Dir.CENTER:
#			switch_anim("Idle")
#		_:
#			switch_anim("Run")
#
#func spriteDir_loop():
#	match moveDir:
#		Dir.LEFT:
#			spriteDir = "Left"
#		Dir.RIGHT:
#			spriteDir = "Right"
#		Dir.UP:
#			spriteDir = "Up"
#		Dir.DOWN:
#			spriteDir = "Down"
#
#func switch_anim(animation):
#	var newAnim = str(animation, spriteDir)
#	if $anim.current_animation != newAnim:
#		$anim.play(newAnim)
#
#
#func controls_loop():
#	var LEFT = Input.is_action_pressed("ui_left")
#	var RIGHT = Input.is_action_pressed("ui_right")
#	var UP = Input.is_action_pressed("ui_up")
#	var DOWN = Input.is_action_pressed("ui_down")
#
#	moveDir.x = -int(LEFT) + int(RIGHT)
#	moveDir.y = -int(UP) + int(DOWN)
#
#
## Receives an "area_entered" signal from hitbox_collision
#func collide_with_smth(body):
#	if body.get == "hitbox" or true:
#		print("get damage")
#
#
#func fun():
#	print(a)