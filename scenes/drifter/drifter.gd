extends KinematicBody2D

# Thess classes contain some of the logic of the state.
# I passed part of logic into the classes in order to organize code and
# easier to read, because big amount of functions in one place(in this case in main drifter's class) makes code
# harder to read and understand, because sometimes you don't for what this
# function is, but if you see this function in a particular class it makes everything cleaner
class MoveStateObject: 
	func _init():
		pass

	static func checkIfAttack():
		return InputEventMouseButton.pressed()
		
class AttackStateObject:
	var isAnimationFinished
	var directions
	
	func _init():
		self.isAnimationFinished = false
		self.directions = [Dir.RIGHT, Dir.UP, Dir.LEFT, Dir.DOWN]
		
	# Receives signal from $anim node, that animation is finished
	func animationFinished(anim_name):
		if anim_name.begins_with("Attack"):
			self.isAnimationFinished = true
	
	# Returns one of the four vectors of Direction class(in code it's called Dir)
	func getMainDirection(vector):
		var angle = vector.angle_to(Dir.RIGHT)
		var angleQuarter = round(angle / (PI/2))
		if angleQuarter == 4:
			angleQuarter = 0
		
		return self.directions[angleQuarter]
		
const MAX_HEALTH = 5
var health = MAX_HEALTH

const MAX_SPEED = 100.0
var speed = MAX_SPEED

enum State { MOVE, ATTACK, DASH, HITTED }
const STARTING_STATE = State.MOVE
var state = STARTING_STATE

var spriteDirection = "Down"
var moveDirection = Dir.CENTER
var attackDirection = Dir.CENTER

var isAllowedSetAttackDirection = true
var isAllowedSetMoveDirectionByInput = true
var isAllowedSetSpriteDirection = true
var isAllowedUpdatePosition = true

var moveStateObject = MoveStateObject.new()
var attackStateObject = AttackStateObject.new()

func _ready():
	$anim.connect("animation_finished", self.attackStateObject, "animationFinished")

func _physics_process(delta):
	if isAllowedSetAttackDirection:
		setAttackDirection()
	if isAllowedSetMoveDirectionByInput:
		setMoveDirectionByInput()
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

# -----------------------------------------------STATE FUNCTIONS----------------------------------------------------------------------
func moveLogic():
	isAllowedSetAttackDirection = true
	isAllowedUpdatePosition = true
	isAllowedSetSpriteDirection = true
	isAllowedSetMoveDirectionByInput = true
	
	if Input.is_action_just_pressed("mouse_left_click"):
		state = State.ATTACK
		speed = MAX_SPEED * 2
	
func attackLogic():
	isAllowedSetAttackDirection = false
	isAllowedUpdatePosition = true
	isAllowedSetSpriteDirection = false
	isAllowedSetMoveDirectionByInput = false
	
	moveDirection = attackDirection
	
	if speed > 0:
		speed -= 10
	elif speed < 0:
		speed = 0
	
	if attackStateObject.isAnimationFinished:
		attackStateObject.isAnimationFinished = false
		state = State.MOVE
		speed = MAX_SPEED

func dashLogic():
	pass
	
func hittedLogic():
	pass


# -----------------------------------------------PROPERTY FUNCTIONS----------------------------------------------------------------------

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
	# Sprite direciton changing depends on current state
	var checkValue
	if state == State.MOVE:
		checkValue = moveDirection
	if state == State.ATTACK:
		# attackDirection usually doesn't contain vectors like 
		# Vector2(1, 0) (Dir.RIGHT), but vectors like Vector(1.23124, 45.12144).
		# Match statement below can't math these vectors, so we get
		# the "longest projection" on the main axises and normalize it.
		checkValue = attackStateObject.getMainDirection(attackDirection)
		
	match checkValue:
		Dir.LEFT:
			spriteDirection = "Left"
		Dir.RIGHT:
			spriteDirection = "Right"
		Dir.DOWN:
			spriteDirection = "Down"
		Dir.UP:
			spriteDirection = "Up"

func setMoveDirectionByInput():
	# Later it won't be one the parameters that has
	# isAllowed@@@ field.
	# Currently I'm planning to set moveDirection in the stateLogic.
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	
	moveDirection.x = -int(LEFT) + int(RIGHT)
	moveDirection.y = -int(UP) + int(DOWN)
	
func setAttackDirection():
	var attackDirectionVector = self.get_global_mouse_position() - self.position
	attackDirection = attackDirectionVector.normalized()
	
func updatePosition():
	var motion = moveDirection.normalized() * speed
	move_and_slide(motion)
