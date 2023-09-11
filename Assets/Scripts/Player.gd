extends CharacterBody3D


const SPEED = 8.0
const JUMP_VELOCITY = 4.5
const ROTATION_DEGREE = 9
#texture rotation offset
const ROTATION_OFFSET = 2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
		#workaround for centering the texture (needs to be rebuilt properly in Blender)
		var offset = ROTATION_OFFSET if velocity.z > 0 else -ROTATION_OFFSET
		
		#rotate the player mesh only
		$MeshInstance3D.look_at(transform.origin + Vector3(-velocity.z, 0, velocity.x + offset),Vector3.UP)
		$MeshInstance3D2.rotate(Vector3(input_dir.y, 0, -input_dir.x).normalized(),deg_to_rad(ROTATION_DEGREE))
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.1)
		velocity.z = lerp(velocity.z, 0.0, 0.1)
	#	velocity.x = move_toward(velocity.x, 0, SPEED)
	#	velocity.z = move_toward(velocity.z, 0, SPEED)

	
	move_and_slide()


func _on_enemy_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://Assets/Scenes/GameOver.tscn")
