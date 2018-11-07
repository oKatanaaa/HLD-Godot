extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	if typeof($drifter) == TYPE_MAX:
		print("Type is " + str(typeof($drifter)))
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
