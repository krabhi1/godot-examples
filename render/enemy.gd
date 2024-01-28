extends Node2D
var pos = Vector2.ZERO

var rectColor = Utils.randomColor()


#get main script
func _ready():
	pos = position + Vector2(100, 100)
	pass


func _process(_delta):
	Global.drawLine(position, pos)
	# Global.drawRectGrid(pos)
	# Global.drawCircle(pos + Vector2(60, 60))
	Global.drawRect(pos, Vector2(10, 10), rectColor)
	pass
