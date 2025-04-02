class_name Character
extends CharacterBody2D

signal custom_signal()
signal pass_jump(partner:Character)

enum PLAYER{
	ONE,
	TWO,
}

@export var player: PLAYER = PLAYER.ONE
@export var speed: float = 300.0
@export var jump_velocity = -400.0
@export var gravity_scale = Vector2(1, 1)
@export var gravity:Vector2 = Vector2(0, 980)
@export var partner:Character

@onready var jump_indicator: Sprite2D = %JumpIndicator

var can_jump:bool = false :
	set = _set_can_jump


func _set_can_jump(val):
	can_jump = val
	
	#jump_indicator.visible = val
	#jump_indicator.global_position = partner.global_position - Vector2(0, 139.0)
	#
	#var tween := create_tween()
	#tween.set_ease(Tween.EASE_OUT)
	#tween.set_trans(Tween.TRANS_BACK)
	#tween.tween_property(jump_indicator, "position", Vector2(0, -139.0), 0.4)


func _physics_process(delta: float) -> void:
	var jump_input: bool
	var direction: float
	var give_jump_input: bool

	if player == PLAYER.ONE:
		jump_input = Input.is_action_just_pressed('ui_accept')
		give_jump_input = Input.is_action_just_pressed('player1_give')
		direction = Input.get_axis("ui_left", "ui_right")
	elif player == PLAYER.TWO:
		jump_input = Input.is_action_just_pressed('player2_jump')
		give_jump_input = Input.is_action_just_pressed('player2_give')
		direction = Input.get_axis("player2_left", "player2_right")

	if give_jump_input and can_jump:
		can_jump = false
		partner.can_jump = true
		pass_jump.emit(partner)

	# Add the gravity.
	if not is_on_floor():
		velocity += gravity * gravity_scale * delta

	# Handle jump.
	if jump_input and is_on_floor() and can_jump:
		custom_signal.emit()
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
