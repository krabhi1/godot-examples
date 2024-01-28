# class_name Global
extends Node2D

var speed = 40
var linesVectorPool = PoolVector2Array()
var linesColorPool = PoolColorArray()

var Utils = preload("res://scripts/Utils.gd")
var DebugPanel = preload("res://scripts/DebugPanel.gd")
var debugPanel: DebugPanel


func _ready():
	print("Global::ready")
	debugPanel = DebugPanel.new()
	get_tree().root.call_deferred("add_child", debugPanel)
	pass


func _draw():
	#draw circles
	if linesVectorPool.size() > 2:
		draw_multiline_colors(linesVectorPool, linesColorPool, 1.0, false)
		linesVectorPool = PoolVector2Array()
		linesColorPool = PoolColorArray()


func _process(_delta):
	debug("fps", str(getFPS()))
	debug("draw_call", str(getDrawCall()))
	update()


func getFPS():
	return Performance.get_monitor(Performance.TIME_FPS)

func getDrawCall():
	return Performance.get_monitor(Performance.RENDER_2D_DRAW_CALLS_IN_FRAME)

func drawLine(start: Vector2, end: Vector2, color: Color = Color.red):
	linesVectorPool.append(start)
	linesVectorPool.append(end)
	linesColorPool.append(color)
	linesColorPool.append(color)


func drawRect(center: Vector2, size: Vector2 = Vector2(50, 50), color: Color = Color.orange):
	var halfSize = size / 2
	var topLeft = center - halfSize
	var topRight = Vector2(center.x + halfSize.x, center.y - halfSize.y)
	var bottomRight = center + halfSize
	var bottomLeft = Vector2(center.x - halfSize.x, center.y + halfSize.y)

	drawLine(topLeft, topRight, color)
	drawLine(topRight, bottomRight, color)
	drawLine(bottomRight, bottomLeft, color)
	drawLine(bottomLeft, topLeft, color)


#drawRectGrid in draw grid inside the react grid_space=4
func drawRectGrid(center: Vector2, size: Vector2 = Vector2(50, 50), color: Color = Color.orange):
	var halfSize = size / 2
	var topLeft = center - halfSize
	var topRight = Vector2(center.x + halfSize.x, center.y - halfSize.y)
	var bottomRight = center + halfSize
	var bottomLeft = Vector2(center.x - halfSize.x, center.y + halfSize.y)

	drawLine(topLeft, topRight, color)
	drawLine(topRight, bottomRight, color)
	drawLine(bottomRight, bottomLeft, color)
	drawLine(bottomLeft, topLeft, color)
	#auto calculate grid_space

	var grid_space = min(10, min(size.x, size.y))
	var grid_size = size / grid_space
	var grid_half_size = grid_size / 2
	var grid_center = center - halfSize + grid_half_size

	for i in range(grid_space):
		for j in range(grid_space):
			var grid_top_left = (
				grid_center
				+ Vector2(i * grid_size.x, j * grid_size.y)
				- grid_half_size
			)
			var grid_top_right = (
				grid_center
				+ Vector2((i + 1) * grid_size.x, j * grid_size.y)
				- grid_half_size
			)
			var grid_bottom_right = (
				grid_center
				+ Vector2((i + 1) * grid_size.x, (j + 1) * grid_size.y)
				- grid_half_size
			)
			var grid_bottom_left = (
				grid_center
				+ Vector2(i * grid_size.x, (j + 1) * grid_size.y)
				- grid_half_size
			)

			drawLine(grid_top_left, grid_top_right, color)
			drawLine(grid_top_right, grid_bottom_right, color)
			drawLine(grid_bottom_right, grid_bottom_left, color)
			drawLine(grid_bottom_left, grid_top_left, color)


func drawCircle(center: Vector2, radius: float = 10, color: Color = Color.red):
	var segments = max(64, int(radius / 10))
	var increment = 2 * PI / segments
	var sinInc = sin(increment)
	var cosInc = cos(increment)
	var r1 = Vector2(1, 0)
	var v1 = center + radius * r1

	for _i in range(segments):
		var r2 = Vector2(cosInc * r1.x - sinInc * r1.y, sinInc * r1.x + cosInc * r1.y)
		var v2 = center + radius * r2
		drawLine(v1, v2, color)
		r1 = r2
		v1 = v2


func debug(key: String, value: String):
	debugPanel.set(key, str(value))
