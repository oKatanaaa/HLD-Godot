extends AnimationPlayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	self.current_animation = "New Anim"
	pass

func _process(delta):
	
	pass

func replay():
	self.current_animation = "New Anim"