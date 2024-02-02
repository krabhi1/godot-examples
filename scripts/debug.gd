extends Node2D
#---------------ui panel-----------------
var font: Font
var keyValues: Dictionary = {}

var maxKeyWidth = 0
var maxValueWidth = 0
var padding = {"left": 5, "top": 5, "right": 5, "bottom": 5}
var isOpen = true
var textGap = 3
var keyValueGap = 10
#---------------drawing panel-----------------
var rid: RID

var verticesPool = PoolVector2Array()
var colorsPool = PoolColorArray()
var indicesPool = PoolIntArray()
#---------------node callback-----------------


func _ready():
	position = Vector2(5, 5)
	_ready_render()
	_initDebugPanel()
	# add node last to make sure it is on top
	z_index = 999
	pass


func _input(event):
	_input_panel(event)
	pass


func _process(_delta):
	update()
	#fps
	logUI("FPS", str(Utils.getFPS()))
	#draw call
	logUI("DrawCall", str(Utils.getDrawCall()))
	pass


func _draw():
	_draw_render()
	_draw_panel()
	pass


#---------------ui panel-----------------


func _initDebugPanel():
	name = "Debug"
	font = Control.new().get_font("font")
	updateMaxWidth()
	print("DebugPanel ready" + str(position.x) + "," + str(position.y))
	pass


func _draw_panel():
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


func _input_panel(event):
	if event is InputEventMouseButton:
		if event.doubleclick and event.button_index == BUTTON_LEFT:
			isOpen = !isOpen


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


func logUI(key: String, value: String) -> void:
	updateMaxWidth(key, value)
	keyValues[key] = value
	pass


#---------------drawing panel-----------------


func _ready_render():
	rid = get_canvas_item()
	pass


func _draw_render():
	if verticesPool.size() > 0:
		VisualServer.canvas_item_add_triangle_array(rid, indicesPool, verticesPool, colorsPool)
		_clear_render()
	pass


func _clear_render():
	verticesPool = PoolVector2Array()
	colorsPool = PoolColorArray()
	indicesPool = PoolIntArray()
	pass


func addTriangle(v1, v2, v3, color):
	#check point is visible in viewport
	if (
		not get_viewport_rect().has_point(v1)
		and not get_viewport_rect().has_point(v2)
		and not get_viewport_rect().has_point(v3)
	):
		return
	var index = verticesPool.size()
	verticesPool.append_array([v1, v2, v3])
	colorsPool.append_array([color, color, color])
	indicesPool.append_array([index, index + 1, index + 2])
	pass


func drawLine(a: Vector2, b: Vector2, color: Color = Color.whitesmoke, width: float = 1) -> void:
	width = width / 2.0
	#find the normal of the line
	var normal = (b - a).normalized().tangent()
	#find the points of the line
	var p1 = a + normal * width
	var p2 = a - normal * width
	var p3 = b + normal * width
	var p4 = b - normal * width
	#add two triangle
	addTriangle(p1, p2, p3, color)
	addTriangle(p2, p3, p4, color)


func drawPolyLine(points: Array, color: Color = Color.orangered, width: float = 1):
	var s = points.size()
	for i in range(0, s - 1):
		drawLine(points[i], points[i + 1], color, width)
	pass


func drawRect(rect: Rect2, color: Color = Color.red, width = 1) -> void:
	var p1 = Vector2(rect.position.x, rect.position.y)
	var p2 = Vector2(rect.position.x + rect.size.x, rect.position.y)
	var p3 = Vector2(rect.position.x + rect.size.x, rect.position.y + rect.size.y)
	var p4 = Vector2(rect.position.x, rect.position.y + rect.size.y)
	drawPolyLine([p1, p2, p3, p4, p1], color, width)
	pass


# func drawCircle(position: Vector2, radius: float, color: Color = Color.blue) -> void:
# 	pass


func drawFilledRect(rect: Rect2, color: Color = Color.orange) -> void:
	var p1 = Vector2(rect.position.x, rect.position.y)
	var p2 = Vector2(rect.position.x + rect.size.x, rect.position.y)
	var p3 = Vector2(rect.position.x + rect.size.x, rect.position.y + rect.size.y)
	var p4 = Vector2(rect.position.x, rect.position.y + rect.size.y)
	addTriangle(p1, p2, p3, color)
	addTriangle(p1, p3, p4, color)


func drawFilledCircle(center: Vector2, radius: float, color: Color = Color.aqua) -> void:
	var circumeference = 2 * PI * radius
	var segments = max(min(int(radius * 8 / 9.0), 10), int(circumeference / 10))
	var increment = 2 * PI / segments
	var sinInc = sin(increment)
	var cosInc = cos(increment)
	var r1 = Vector2(1, 0)
	var r2 = Vector2(cosInc, sinInc)
	var v1 = center + r1 * radius
	var v2 = center + r2 * radius
	for _i in range(0, segments):
		var v3 = v2
		r2 = Vector2(cosInc * r2.x - sinInc * r2.y, sinInc * r2.x + cosInc * r2.y)
		v2 = center + r2 * radius
		addTriangle(v1, v2, v3, color)
		pass
