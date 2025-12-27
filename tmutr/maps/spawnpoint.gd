extends Node

@onready var spawnpoint = $spawnpoint
var player: Node = null
var pointofspawn: Vector2

func _ready():
	# Wait for everything to load
	await get_tree().process_frame
	
	# Get player from group
	player = get_tree().get_first_node_in_group("player")
	
	if player:
		print("Player found!")
		# Store initial spawn position
		pointofspawn = spawnpoint.global_position
	else:
		print("Player not found!")

func _process(delta):
	_movespawnpoint()
	_resetfromspawnpoint()

func _movespawnpoint():
	if Input.is_action_just_pressed("newspawnpoint") and player:
		# Update spawn point to current player position
		pointofspawn = player.global_position
		print("New spawn point set: ", pointofspawn)

func _resetfromspawnpoint():
	if Input.is_action_just_pressed("resetfromspawnpoint") and player:
		# Reset player to spawn point
		player.global_position = pointofspawn
		print("Player reset to spawn point: ", pointofspawn)
