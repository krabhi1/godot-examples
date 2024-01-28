extends Node2D
var pos = Vector2.ZERO


#get main script
func _ready():
	pos = position + Vector2(100, 100)
	pass


func _process(_delta):
	Global.drawLine(position, pos)
	Global.drawRectGrid(pos)
	Global.drawCircle(pos + Vector2(60, 60))
	Global.drawRect(pos + Vector2(160, 60))
	Global.debug(name + "_pos", str(pos.x) + " " + str(pos.y))
	pass
