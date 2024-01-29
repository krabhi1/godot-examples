extends MeshInstance2D


static func get_MeshInstance2D(pos, count):
	var vertices = PoolVector3Array()
	var colors = PoolColorArray()
	for _i in range(0, count):
		var v = Utils.eqivalentTriangle(Utils.randomVec3(1300, 750), 5)
		vertices.append(v[0])
		vertices.append(v[1])
		vertices.append(v[2])
		colors.append(Utils.randomColor())
		colors.append(Utils.randomColor())
		colors.append(Utils.randomColor())
	var arr_mesh = ArrayMesh.new()
	var arrays = []
	arrays.resize(ArrayMesh.ARRAY_MAX)
	arrays[ArrayMesh.ARRAY_VERTEX] = vertices
	arrays[ArrayMesh.ARRAY_COLOR] = colors
	# Create the Mesh.
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	var newInstance = MeshInstance2D.new()
	newInstance.set_mesh(arr_mesh)
	newInstance.set_position(pos)
	return newInstance


#index based
static func get_MeshInstance2D2(pos, count):
	var vertices = PoolVector3Array()
	var colors = PoolColorArray()
	var indices = PoolIntArray()
	for _i in range(0, count):
		var v = Utils.eqivalentTriangle(Utils.randomVec3(1300, 750), 50)
		vertices.append(v[0])
		vertices.append(v[1])
		vertices.append(v[2])
		indices.append(0)
		indices.append(1)
		indices.append(2)
		colors.append(Utils.randomColor())
		colors.append(Utils.randomColor())
		colors.append(Utils.randomColor())
	var arr_mesh = ArrayMesh.new()
	var arrays = []
	arrays.resize(ArrayMesh.ARRAY_MAX)
	arrays[ArrayMesh.ARRAY_VERTEX] = vertices
	arrays[ArrayMesh.ARRAY_INDEX] = indices
	arrays[ArrayMesh.ARRAY_COLOR] = colors
	# Create the Mesh.
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	var newInstance = MeshInstance2D.new()
	newInstance.set_mesh(arr_mesh)
	newInstance.set_position(pos)
	return newInstance


func _ready():
	var faces = mesh.get_faces()
	print("faces", "=", faces)
	print("faces size ", mesh.get_faces().size())

	var node1 = get_MeshInstance2D2(Vector2(0, 0), 50000)
	call_deferred("add_child", node1)

	pass  # Replace with function body.






# var vertices = PoolVector3Array()
# var colors = PoolColorArray()
# var indices = PoolIntArray()

# var arr_mesh = ArrayMesh.new()
# var arrays = []

# func load_data(pos):
# 	var index = 0
# 	if indices.size() > 0:
# 		index = indices[indices.size() - 1]
# 	for _i in range(0, 10000):
# 		var v = Utils.eqivalentTriangle(Utils.randomVec3(1000, 500), 20)
# 		vertices.append(v[0])
# 		vertices.append(v[1])
# 		vertices.append(v[2])
# 		indices.append(index + 0)
# 		indices.append(index + 1)
# 		indices.append(index + 2)
# 		colors.append(Utils.randomColor())
# 		colors.append(Utils.randomColor())
# 		colors.append(Utils.randomColor())
# 		index += 3
# 	pass

# func _ready():
# 	load_data(Vector2(200, 200))
# 	arrays.resize(ArrayMesh.ARRAY_MAX)
# 	rebuild()

# 	pass

# func _draw():
# 	draw_mesh(arr_mesh, null)
# 	clean()
# 	pass

# var time = 0
# var count = 0

# func _process(_delta):
# 	time += _delta
# 	if time > 1:
# 		load_data(Vector2(100 * count, 200))
# 		count += 1
# 		print(count)
# 		rebuild()
# 	update()
# 	pass

# func rebuild():
# 	# arr_mesh.clear_surfaces()
# 	# arrays[ArrayMesh.ARRAY_VERTEX] = vertices
# 	# arrays[ArrayMesh.ARRAY_INDEX] = indices
# 	# arrays[ArrayMesh.ARRAY_COLOR] = colors
# 	# arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
# 	pass

# func clean():
# 	vertices = PoolVector3Array()
# 	colors = PoolColorArray()
# 	indices = PoolIntArray()
# 	pass

