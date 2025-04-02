extends Node2D

@export var player1:Character

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var players := get_tree().get_nodes_in_group('character')
	
	for char:Character in players:
		char.custom_signal.connect(_on_custom_signal)
		if char.player == Character.PLAYER.ONE:
			char.can_jump = true


func _on_custom_signal():
	print("custom signal was called")
