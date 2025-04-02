extends Node2D

@export var player1:Character

@onready var jump_indicator: Sprite2D = %JumpIndicator

var tween: Tween


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var players := get_tree().get_nodes_in_group('character')
	
	for char:Character in players:
		char.pass_jump.connect(_on_pass_jump)
		if char.player == Character.PLAYER.ONE:
			jump_indicator.reparent(char)
			jump_indicator.position = Vector2(0, -139)
			char.can_jump = true


func _on_pass_jump(char: Character) -> void:
	print('pass jump')
	jump_indicator.reparent(char)
	
	if tween:
		tween.kill()
	
	tween = create_tween()
	tween.set_parallel(true)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_BACK)
	tween.tween_property(jump_indicator, 'position:x', 0, 0.45)
	tween.tween_property(jump_indicator, 'position:y', -139, 0.3)
