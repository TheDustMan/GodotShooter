extends CharacterBody2D

signal laser
signal grenade

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
	
	if Input.is_action_pressed("primary action") and can_laser:
		print("shoot laser")
		can_laser = false
		$LaserTimer.start()
		laser.emit()

	if Input.is_action_pressed("secondary action") and can_grenade:
		print("shoot grenade")
		can_grenade = false
		$GrenadeTimer.start()
		grenade.emit()

func _on_grenade_timer_timeout():
	can_grenade = true

func _on_laser_timer_timeout():
	can_laser = true
