extends Area2D
class_name Cannon
export var speed = 25
export var direction = Vector2(0, 0)

func _process(delta):
	var velocity = direction * speed
	rotation = direction.angle()
	# rotation=direction.angle()
	# move_and_slide(velocity)
	# position += velocity * delta
	Debug.logUI("velocity:: ", str(velocity))
	Debug.logUI("dir:: ", str(direction))

	position += velocity * delta



func _on_cannon_body_entered(body:Node):
	print("Cannon body entered"+str(body))
	queue_free()
	pass # Replace with function body.
