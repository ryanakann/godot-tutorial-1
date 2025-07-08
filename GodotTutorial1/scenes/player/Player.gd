extends Area2D

@export var speed = 400 # Speed of the player in pixels per second
var screen_size # Size of the game screen

signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide() # Hide the player initially
	start(screen_size / 2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	# Normalize the velocity vector to ensure consistent speed in all directions
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	$AnimatedSprite2D.flip_v = velocity.y > 0
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)


func _on_body_entered(body:Node2D):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true) # Disable collision shape to prevent further collisions

func start(pos):
	position = pos
	show()
	$CollisionShape2D.set_deferred("disabled", false) # Enable collision shape when starting