extends KinematicBody2D

signal shoot(position, direction)

export(int) var speed = 200
export(float) var rotation_speed = 1.8
export var barrelSpeed = 0.03
onready var barrel = $barrel
onready var barrelPoint = $barrel/point

var velocity = Vector2()
var acceleration = 8
var deacceleration = acceleration * 0.5


#rotation
var rotation_acceleration = 10
var rotation_deacceleration = rotation_acceleration * 0.3
var rotation_velocity = 0

#shoot info
var shoot_rate=5 #bullets per second
var last_shoot_time=0

func handle_movement(delta):
	var target_velocity = Vector2()
	
	if Input.is_action_pressed("up"):
			target_velocity = Vector2(1, 0).rotated(rotation)
	if Input.is_action_pressed("down"):
			target_velocity = Vector2( - 1, 0).rotated(rotation)
	target_velocity = target_velocity.normalized() * speed
	if target_velocity.length() == 0:
		velocity = velocity.linear_interpolate(Vector2(), deacceleration * delta)
	else:
		velocity = velocity.linear_interpolate(target_velocity, acceleration * delta)
	velocity = move_and_slide(velocity)
	Debug.logUI("velocity", str(velocity))
	Debug.logUI("angle", str(velocity.angle()) + " " + str(rotation))

func handle_rotation(delta):
	var target_rotation = 0
	if Input.is_action_pressed("left"):
			target_rotation -= 1
	if Input.is_action_pressed("right"):
			target_rotation += 1
	# target_rotation = target_rotation * rotation_speed
	# if target_rotation == 0:
	# 	rotation_velocity = lerp(rotation_velocity,0, rotation_deacceleration * get_physics_process_delta_time())
	# else:
	# 	rotation_velocity = lerp(rotation_velocity,target_rotation, rotation_acceleration * get_physics_process_delta_time())
	# var rad_velocity=deg2rad(rotation_velocity)*get_physics_process_delta_time()
	if target_rotation == 0:
		# rotation=-velocity.angle()
		pass
	else:
		rotation += target_rotation * rotation_speed * delta

func handle_barrel_rotation(_delta):
	Utils.lookAtSmooth(barrel, get_global_mouse_position(), barrelSpeed)
	pass
func _physics_process(delta):
	handle_movement(delta)
	handle_rotation(delta)
	handle_barrel_rotation(delta)

func _input(event):
	if event is InputEventKey and event.pressed:
			if event.scancode == KEY_SPACE:
				_shoot()

func _shoot():
	var current_time=Time.get_ticks_msec()
	if current_time - last_shoot_time > 1000 / shoot_rate:
		last_shoot_time = current_time
		emit_signal("shoot", barrelPoint.global_position, Vector2(1, 0).rotated(barrel.global_rotation))

	pass
