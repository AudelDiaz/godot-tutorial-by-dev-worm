extends CharacterBody2D

const SPEED:int = 80
var player_chase:bool = false
var player = null
@onready var animation = $AnimatedSprite2D

func _physics_process(_delta):
	if player_chase:
		position += (player.position - position)/SPEED
		animation.play("walk")
		if (player.position.x - position.x) < 0:
			animation.flip_h = true
		else:
			animation.flip_h = false
	else:
		animation.play("idle")

func _on_detection_area_body_entered(body):
	if body != self:
		player = body
		player_chase = true
	

func _on_detection_area_body_exited(_body):
	if _body != self:
		player = null
		player_chase = false
	
