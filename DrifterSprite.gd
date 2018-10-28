extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$AnimationPlayer.play()
	pass

func _process(delta):
	pass

func change_sprite_frame():
	if self.frame == 11:
	 	frame = 0
	else:
		frame += 1 
