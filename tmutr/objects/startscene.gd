extends Node2D

@onready var mehet = $Button

var megy = false

func _ready() -> void:
	megy = false  # Ensure it starts as false
	mehet.pressed.connect(_on_button_pressed)
	print("Scene loaded, waiting for button press...")

func _on_button_pressed():
	print("Button pressed!")
	megy = true
	_menjen()

func _menjen():
	if megy == true:
		print("Changing scene...")
		get_tree().change_scene_to_file("res://maps/map1.tscn")
