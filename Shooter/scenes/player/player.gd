extends CharacterBody2D

signal laser(pos: Vector2)
signal grenade(pos: Vector2, direction: Vector2)

var can_laser: bool = true
var can_grenade: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	print('player _ready')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * 500 
	move_and_slide()
	
	# rotate
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("primary action") and can_laser:
		# randomly select a marker 2d for the laser spawn point
		var laser_markers = $LaserStartPositions.get_children()
		var selected_marker = laser_markers[randi() % laser_markers.size()]
		can_laser = false
		$LaserTimer.start()
		# emit the position we selected
		laser.emit(selected_marker.global_position)

	if Input.is_action_pressed("secondary action") and can_grenade:
		var grenade_markers = $LaserStartPositions.get_children()
		var selected_marker = grenade_markers[randi() % grenade_markers.size()]
		var player_direction = (get_global_mouse_position() - position).normalized()
		can_grenade = false
		$GrenadeTimer.start()
		grenade.emit(selected_marker.global_position, player_direction)

func _on_grenade_timer_timeout():
	can_grenade = true

func _on_laser_timer_timeout():
	can_laser = true
