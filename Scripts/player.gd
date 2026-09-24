extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const GRAVITY = 1200.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta):

	# Gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Jump dengan W
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Gerakan kiri kanan
	var direction = Input.get_axis("move_left", "move_right")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Animasi
	if not is_on_floor():
		animated_sprite_2d.play("jump")
	elif direction != 0:
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("idle")

	# Balik arah sprite
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true

	move_and_slide()
