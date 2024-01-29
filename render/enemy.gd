extends Node2D
var pos = Vector2.ZERO

var rectColor = Utils.randomColor()


#get main script
func _ready():
	pos = position + Vector2(100, 100)
	pass


func _process(_delta):
	Global.render.addLine(position, pos)
	Global.render.addFillRect(Rect2(pos, Vector2(10, 10)), rectColor)
	pass
