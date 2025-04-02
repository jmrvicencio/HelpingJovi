extends CharacterBody2D

enum PLAYER{
	ONE,
	TWO,
}

@export var player: PLAYER = PLAYER.ONE

@export var speed: float = 300.0
@export var jump_velocity = -400.0
@export var gravity_scale = Vector2(1, 1)
@export var gravity:Vector2 = Vector2(0, 980)


func _physics_process(delta: float) -> void:
	var jump_input: bool
	var direction: float
	if player == PLAYER.ONE:
		jump_input = Input.is_action_just_pressed('ui_accept')
		direction = Input.get_axis("ui_left", "ui_right")
	elif player == PLAYER.TWO:
		jump_input = Input.is_action_just_pressed('player2_jump')
		direction = Input.get_axis("player2_left", "player2_right")

	# Add the gravity.
	if not is_on_floor():
		print("i am not on floor")
		velocity += gravity * gravity_scale * delta

	# Handle jump.
	if jump_input and is_on_floor():
		print("time to jump bitch")
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
