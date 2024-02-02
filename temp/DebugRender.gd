class_name DebugRender
extends Node2D

var rid: RID

var verticesPool = PoolVector2Array()
var colorsPool = PoolColorArray()
var indicesPool = PoolIntArray()


func tri(center, radius):
	var v1 = Vector2(center.x, center.y - radius)
	var v2 = Vector2(center.x + radius * 0.866, center.y + radius * 0.5)
	var v3 = Vector2(center.x - radius * 0.866, center.y + radius * 0.5)
	return [v1, v2, v3]


func _ready():
	rid = get_canvas_item()
	pass


func _process(_delta):
	if verticesPool.size() > 0:
		update()
		pass
	# Global.debug("Debug triangles", str(verticesPool.size() / 3))


func _draw():
	if verticesPool.size() > 0:
		VisualServer.canvas_item_add_triangle_array(rid, indicesPool, verticesPool, colorsPool)
		clear()


func gen():
	for _i in range(0, 5000):
		addTriangle(Utils.randomVec2(1400, 800), rand_range(5, 10), Utils.randomColor())
	pass


func clear():
	verticesPool = PoolVector2Array()
	colorsPool = PoolColorArray()
	indicesPool = PoolIntArray()
	pass


#drawing function
func addTriangle(center, radius, color):
	var index = verticesPool.size()
	verticesPool.append_array(tri(center, radius))
	colorsPool.append_array([color, color, color])
	indicesPool.append_array([index, index + 1, index + 2])
	pass


func addTriangle2(v1, v2, v3, color):
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


func addLine(a, b, color = Color.orange, width = 1):
	width = width / 2.0
	#find the normal of the line
	var normal = (b - a).normalized().tangent()
	#find the points of the line
	var p1 = a + normal * width
	var p2 = a - normal * width
	var p3 = b + normal * width
	var p4 = b - normal * width
	#add two triangle
	addTriangle2(p1, p2, p3, color)
	addTriangle2(p2, p3, p4, color)


func addFillRect(rect, color):
	var p1 = Vector2(rect.position.x, rect.position.y)
	var p2 = Vector2(rect.position.x + rect.size.x, rect.position.y)
	var p3 = Vector2(rect.position.x + rect.size.x, rect.position.y + rect.size.y)
	var p4 = Vector2(rect.position.x, rect.position.y + rect.size.y)
	addTriangle2(p1, p2, p3, color)
	addTriangle2(p1, p3, p4, color)


func addFillRect2(rect: Rect2, angle: float, color: Color):
	var center = rect.position + rect.size / 2
	var points = [
		rect.position,
		Vector2(rect.position.x + rect.size.x, rect.position.y),
		Vector2(rect.position.x + rect.size.x, rect.position.y + rect.size.y),
		Vector2(rect.position.x, rect.position.y + rect.size.y)
	]

	for i in range(points.size()):
		var point = points[i] - center
		var rotated_x = point.x * cos(angle) - point.y * sin(angle)
		var rotated_y = point.x * sin(angle) + point.y * cos(angle)
		points[i] = Vector2(rotated_x, rotated_y) + center

	addTriangle2(points[0], points[1], points[2], color)
	addTriangle2(points[0], points[2], points[3], color)


func addFillCircle(center: Vector2, radius: float, color: Color):
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
		addTriangle2(v1, v2, v3, color)
		pass


func addPolyLine(points: Array, width: float, color: Color):
	var s = points.size()
	for i in range(0, s - 1):
		addLine(points[i], points[i + 1], color, width)
	pass


func addStrokeRect(rect: Rect2, width: float, color: Color):
	var p1 = Vector2(rect.position.x, rect.position.y)
	var p2 = Vector2(rect.position.x + rect.size.x, rect.position.y)
	var p3 = Vector2(rect.position.x + rect.size.x, rect.position.y + rect.size.y)
	var p4 = Vector2(rect.position.x, rect.position.y + rect.size.y)
	addPolyLine([p1, p2, p3, p4, p1], width, color)
	pass


func addStrokeRect2(rect: Rect2, angle: float, width: float = 1, color: Color = Color.azure):
	var center = rect.position + rect.size / 2
	var points = [
		rect.position,
		Vector2(rect.position.x + rect.size.x, rect.position.y),
		Vector2(rect.position.x + rect.size.x, rect.position.y + rect.size.y),
		Vector2(rect.position.x, rect.position.y + rect.size.y)
	]

	for i in range(points.size()):
		var point = points[i] - center
		var rotated_x = point.x * cos(angle) - point.y * sin(angle)
		var rotated_y = point.x * sin(angle) + point.y * cos(angle)
		points[i] = Vector2(rotated_x, rotated_y) + center

	addPolyLine([points[0], points[1], points[2], points[3], points[0]], width, color)
	pass
