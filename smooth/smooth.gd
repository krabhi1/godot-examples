extends Node2D

onready var box1 = $box1
#speed in pixels per second
var smooth = null
func _ready():
	smooth = Smooth2.new(box1)
	pass
	
func _process(delta):
	smooth.update(delta)
	pass

class BaseSmooth:
	var node = null
	func _init(_node):
		self.node = _node
		pass

	func update(_delta):
		pass

class Smooth1 extends BaseSmooth:
	var speed = 100
	func _init(_node).(_node):
		pass

	func update(delta):
		self.node.position.x += self.speed * delta
		pass

class Smooth2 extends Smooth1:
	var velocity = Vector2()
	var acceleration = 8
	var deacceleration = acceleration * 0.5
	func _init(_node).(_node):
		speed = 200
		pass

	func update(delta):
		var target_velocity = Vector2()
		if Input.is_action_pressed("down"):
			target_velocity = Vector2(0, 1)
		if Input.is_action_pressed("up"):
			target_velocity = Vector2(0, -1)
		target_velocity = target_velocity.normalized() * speed
		if target_velocity.length() == 0:
			velocity = velocity.linear_interpolate(Vector2(), deacceleration * delta)
		else:
			velocity = velocity.linear_interpolate(target_velocity, acceleration * delta)
		
		Debug.drawLine(Vector2.ZERO,node.global_position)
		Debug.logUI("velocity", str(velocity))
		
		node.position += velocity * delta


