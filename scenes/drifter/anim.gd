extends AnimationPlayer
# For what this script is:
# The way I was adding spritesheets before is:
# 1) Create AnimationPlayer node
# 2) Create as many sprite nodes as many sprites you have
# 3) Create animation, add a timeline where frames change
# 4) Add a timeline that makes current sprite visible(just press a button with
# the image of the key at the right of the Visible property of the sprite)
# 5) Add a timelines for all the other sprites, that make these sprites 
# invisible(do the same operation like in point 4, but unmark the Visible property)
# 6) Repeat points 3-5 for each sprite(animation)
# This way of adding spritesheets has a problem - it takes too much time
# for adding new sprites and new animations. You need to repeat all the points
# in the list above and it becomes longer and longer as you get more and more
# sprites and animations. So "narrow neck" of this way is that you need to change
# visibility of particular sprites manually. This script solves this problem
# by making sprite, that currently is used, visible and all the other sprites invisible.

# If you want to add a new sprite and animation, all you need is just to add a new 
# element into the dictionary below <animation name : sprite, which is used by this animation>

var animSpriteMap 

func _ready():
	animSpriteMap = {
	"RunUp" : get_parent().get_node("allSprites/sprRunUp"),
	"RunDown" : get_parent().get_node("allSprites/sprRunDown"),
	"RunLeft" : get_parent().get_node("allSprites/sprRunRight"),
	"RunRight" : get_parent().get_node("allSprites/sprRunRight"),
	
	"IdleUp" : get_parent().get_node("allSprites/sprIdleUp"),
	"IdleDown" : get_parent().get_node("allSprites/sprIdleDown"),
	"IdleLeft" : get_parent().get_node("allSprites/sprIdleRight"),
	"IdleRight" : get_parent().get_node("allSprites/sprIdleRight"),
	
	"AttackUp" : get_parent().get_node("allSprites/sprAttackUp"),
	"AttackDown" : get_parent().get_node("allSprites/sprAttackDown"),
	"AttackLeft" : get_parent().get_node("allSprites/sprAttackRight"),
	"AttackRight" : get_parent().get_node("allSprites/sprAttackRight")
	}
	
	connect("animation_changed", self, "animation_changed")


func _on_anim_animation_started(anim_name):
	for animation in animSpriteMap:
		animSpriteMap[animation].visible = false
	
	animSpriteMap[anim_name].visible = true
