extends MeshInstance2D

static func get_MeshInstance2D(pos,count):
	var vertices = PoolVector3Array()
	var colors = PoolColorArray()
	for _i in range(0, count):
		var v=Utils.eqivalentTriangle(Utils.randomVec3(1000, 500), 20)
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

func _ready():
	var faces = mesh.get_faces()
	print("faces", "=", faces)
	print("faces size ", mesh.get_faces().size())

	var node1=get_MeshInstance2D(Vector2(0,0), 10000)
	call_deferred("add_child", node1)

	pass  # Replace with function body.
