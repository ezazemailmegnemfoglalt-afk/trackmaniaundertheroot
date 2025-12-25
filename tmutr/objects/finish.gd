extends Node2D

@onready var ns = $Endd
@onready var endarea = $Area2D
@onready var back = $endoptions/back
@onready var retry = $endoptions/retry

func _ready():
	ns.visible = false
	back.visible = false
	retry.visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.set_physics_process(false)  
		body.set_process_input(false)
		ns.visible = true
		back.visible = true
		retry.visible = true



func _on_retry_pressed() -> void:
	get_tree().reload_current_scene()


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://maps/mapsw_1.tscn")
