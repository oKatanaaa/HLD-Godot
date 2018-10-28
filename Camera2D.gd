extends Camera2D



# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	var root_node = get_tree().get_root().get_child(0)
	self.position = root_node.position
	pass
