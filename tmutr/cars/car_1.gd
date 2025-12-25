extends CharacterBody2D

@onready var car = $AnimatedSprite2D
@onready var timer = $Timer
@onready var anim = $AnimatedSprite2D

var SPEED = 300.0
var JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	anim.play("default")
	# Connect timer signal once in _ready
	timer.timeout.connect(_backtonormal)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		_reset()
	
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get input direction
	var direction = Input.get_axis("ui_left", "ui_right")
	
	# Handle movement and animation
	if direction != 0:
		anim.play("megy")
		# Flip sprite based on direction
		car.flip_h = (direction < 0)  # True for left, False for right
		velocity.x = direction * SPEED
	else:
		anim.play("default")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func Speeding():
	SPEED = 2000
	timer.wait_time = 0.5
	timer.one_shot = true
	timer.start()
	print("Speeding activated!")

func _jumping():
	JUMP_VELOCITY = -1000.0  # Made it higher for more noticeable jump
	timer.wait_time = 0.5
	timer.one_shot = true
	timer.start()
	print("Jump boosted!")

func _backtonormal():
	JUMP_VELOCITY = -400.0
	SPEED = 300
	print("Back to normal")

func _reset():
	print("Resetting scene...")	
	get_tree().reload_current_scene()
