extends Node2D
var pos = Vector2.ZERO

var rectColor = Utils.randomColor()


#get main script
func _ready():
	pos = position + Vector2(100, 100)
	pass


func _process(_delta):
	Debug.drawLine(position, pos)
	Debug.drawFilledRect(Rect2(position, Vector2(100, 100)), rectColor)

	pass
