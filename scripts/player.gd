extends CharacterBody2D

const SPEED = 100
const IDLE:bool = false
const WALKING:bool = true
var current_direction = null

func _ready():
	$AnimatedSprite2D.play("front_idle")

func _physics_process(_delta):
	player_movement(_delta)
	
func player_movement(_delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity.x = direction.x * SPEED
	velocity.y = direction.y * SPEED
	if direction:
		if direction.x > 0.5:
			current_direction = "right"
		elif direction.x < -0.5:
			current_direction = "left"
		if direction.y > 0.5:
			current_direction = "down"
		elif direction.y < -0.5:
			current_direction = "up"
		play_animation(WALKING)
	else:
		play_animation(IDLE)
	move_and_slide()
	
func play_animation(is_moving):
	var direction = current_direction
	var animation = $AnimatedSprite2D
	
	if direction == "right":
		animation.flip_h = false
		if is_moving:
			animation.play("side_walk")
		else:
			animation.play("side_idle")
	elif direction == "left":
		animation.flip_h = true
		if is_moving:
			animation.play("side_walk")
		else:
			animation.play("side_idle")
	elif direction == "down":
		animation.flip_h = false
		if is_moving:
			animation.play("front_walk")
		else:
			animation.play("front_idle")
	elif direction == "up":
		animation.flip_h = false
		if is_moving:
			animation.play("back_walk")
		else:
			animation.play("back_idle")
	if Input.is_action_pressed("ui_accept"):
		animation.play("side_attack")
		get_tree().create_timer(.5)
