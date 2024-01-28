class_name DebugPanel
extends Node2D

var font: Font
var keyValues: Dictionary = {}

var maxKeyWidth = 0


func _ready():
	name = "Debug"
	font = Control.new().get_font("font")
	updateMaxKeyWidth()
	pass


func _draw():
	draw_set_transform(Vector2(10, 10), 0, Vector2.ONE)
	var valueX = maxKeyWidth + 10
	var valueY = 8
	for key in keyValues.keys():
		var value = keyValues[key]
		draw_string(font, Vector2(0, valueY), key, Color.orange)
		draw_string(font, Vector2(valueX, valueY), value, Color.orange)
		valueY += font.get_height() + 2


func _process(_delta):
	update()
	pass


func set(key: String, value: String):
	if not keyValues.has(key):
		updateMaxKeyWidth(key)
	keyValues[key] = value


func updateMaxKeyWidth(key: String = ""):
	if font == null:
		return

	if key == "":
		#update all
		for key in keyValues.keys():
			updateMaxKeyWidth(key)
		return
	else:
		var keyWidth = font.get_string_size(key).x
		print("keyWidth:" + str(keyWidth))
		if keyWidth > maxKeyWidth:
			maxKeyWidth = keyWidth
