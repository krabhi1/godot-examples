extends KinematicBody2D

export(int) var speed = 200
export(float) var rotation_speed = 1.8

var velocity = Vector2()
var acceleration = 8
var deacceleration = acceleration * 0.5

#rotation
var rotation_acceleration = 10
var rotation_deacceleration = rotation_acceleration * 0.3
var rotation_velocity = 0

func handle_movement(delta):
	var target_velocity = Vector2()
	
	if Input.is_action_pressed("down"):
			target_velocity = Vector2(0, 1).rotated(rotation)
	if Input.is_action_pressed("up"):
			target_velocity = Vector2(0, -1).rotated(rotation)
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
	if Input.is_action_pressed("right"):
			target_rotation += 1
	if Input.is_action_pressed("left"):
			target_rotation -= 1
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

func _physics_process(delta):
	handle_movement(delta)
	handle_rotation(delta)


