extends CharacterBody3D


@export var SPEED = 10.0
@export var Bullet: PackedScene
@export var max_ammo = 10
var ammo = max_ammo

signal ammo_spent(ammo,max_ammo)

func _physics_process(delta):
	movement_function()
	shoot()
	
	if Input.is_action_just_pressed("reload"):
		reload()

func movement_function():
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func shoot():
	
	if Input.is_action_just_pressed("ui_accept") && ammo != 0:
		
		$shoot.play()
		
		var new_bullet = Bullet.instantiate()
		new_bullet.global_transform = $Rotation/Marker3D.global_transform
		new_bullet.scale.x = 0.1
		new_bullet.scale.y = 0.2
		new_bullet.scale.z = 0.2
		
		var scene_root = get_tree().get_root().get_children()[0]
		ammo -=1
		scene_root.add_child(new_bullet)
		emit_signal("ammo_spent",ammo,max_ammo)
		
		
func reload():
	$ReloadSound.play()
	ammo = max_ammo
	emit_signal("ammo_spent",ammo,max_ammo)
		
		
		
		
		
		
		
		
		
