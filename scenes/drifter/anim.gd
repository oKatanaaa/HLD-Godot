extends AnimationPlayer

const DEFAULT_SPEED = 1.0
const AttackRightSpeed = 1.4
func _process(delta):
	if current_animation == "AttackRight":
		playback_speed = AttackRightSpeed
	else:
		playback_speed = DEFAULT_SPEED
