extends CharacterBody2D

@onready var car =  $AnimatedSprite2D
@onready var timer = $Timer
@onready var anim = $AnimatedSprite2D


var SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready() -> void:
	anim.play("default")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		
		if Input.is_action_pressed("ui_left"):
			anim.play("megy")
			car.flip_h = false
			velocity.x = direction * SPEED
		else:
			anim.play("megy")
			car.flip_h = true
			velocity.x = direction * SPEED
	else:
		anim.play("default")
		if car.flip_h == true:
			car.flip_h = true
		else:
			car.flip_h = false
		velocity.x = move_toward(velocity.x, 0, SPEED)


		
	move_and_slide()


func Speeding():
	SPEED = 2000
	timer.wait_time = 0.5
	timer.one_shot = true
	timer.timeout.connect(_backtonormal)
	timer.start()
	print("irwgi")

func _backtonormal():
	SPEED = 300
	print("uizwero")

func _diable_input():
	set_process_input(false)

func _die():
	queue_free()
