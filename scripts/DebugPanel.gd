class_name DebugPanel
extends Node2D

var font: Font
var keyValues: Dictionary = {}

var maxKeyWidth = 0
var maxValueWidth = 0
var padding = {"left": 5, "top": 5, "right": 5, "bottom": 5}
var isOpen = true
var textGap = 3
var keyValueGap = 10


func _ready():
	name = "Debug"
	font = Control.new().get_font("font")
	updateMaxWidth()
	print("DebugPanel ready" + str(position.x) + "," + str(position.y))
	pass


#onclick event print hello
func _input(event):
	if event is InputEventMouseButton:
		if event.doubleclick and event.button_index == BUTTON_LEFT:
			isOpen = !isOpen


func _draw():
	#draw background
	var fontHeight = font.get_height()
	var rect = Rect2(
		0,
		0,
		maxKeyWidth + 10 + maxValueWidth + padding.left + padding.right,
		keyValues.size() * (font.get_height() + textGap) + padding.top + padding.bottom - textGap
	)

	if not isOpen:
		rect.size.y = 2 * (fontHeight + textGap) + padding.top + padding.bottom - textGap
	draw_rect(rect, Color(0, 0, 0, 0.8))
	draw_set_transform(rect.position + Vector2(padding.left, padding.top), rotation, Vector2.ONE)

	var valueY = font.get_ascent()
	var i = 0
	for key in keyValues.keys():
		var value = keyValues[key]
		draw_string(font, Vector2(0, valueY), key, Color.orange)
		draw_string(font, Vector2(maxKeyWidth + keyValueGap, valueY), value, Color.orange)
		valueY += fontHeight + textGap
		i += 1
		if not isOpen and i > 1:
			break


func _process(_delta):
	update()
	pass


func set(key: String, value: String):
	updateMaxWidth(key, value)
	keyValues[key] = value


func updateMaxWidth(key: String = "", value: String = ""):
	if font == null:
		return

	if key == "" and value == "":
		for key in keyValues.keys():
			_updateKeyMaxWidth(key)
			_updateValueMaxWidth(keyValues[key])
		return
	else:
		#if new key
		if not keyValues.has(key):
			_updateKeyMaxWidth(key)
			_updateValueMaxWidth(value)
		else:
			var oldValue = keyValues[key]
			if oldValue != value:
				_updateValueMaxWidth(value)


func _updateKeyMaxWidth(key: String):
	var keyWidth = font.get_string_size(key).x
	if keyWidth > maxKeyWidth:
		maxKeyWidth = keyWidth


func _updateValueMaxWidth(value: String):
	var valueWidth = font.get_string_size(value).x
	if valueWidth > maxValueWidth:
		maxValueWidth = valueWidth
