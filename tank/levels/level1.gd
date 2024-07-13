extends Node2D

var cannonScene: PackedScene = preload ("res://tank/parts/cannon.tscn")


func _ready():
  #timescale
  # Engine.time_scale = 0.05
  pass

func create_cannon(pos, dir):
  var cannon = cannonScene.instance() as Cannon
  cannon.position = pos
  cannon.direction = dir
  add_child(cannon)

func _on_tank_shoot(position: Vector2, direction: Vector2):
  create_cannon(position, direction)








# onready var grass= $ground/grass as Sprite

# func _ready():
# 	#get the size of window
# 	var size=get_viewport_rect().size
# 	#update region of grass
# 	grass.region_rect=Rect2(Vector2(0,0),Vector2(size))
# 	print(size)
# 	var _result = get_tree().connect("screen_resized", self, "_on_Viewport_size_changed")
# 	pass 

# #on window resize
# func _on_Viewport_size_changed():
# 	#get the size of window
# 	var size=get_viewport_rect().size
# 	#update region of grass
# 	grass.region_rect=Rect2(Vector2(0,0),Vector2(size))
# 	print(size)
# 	pass

