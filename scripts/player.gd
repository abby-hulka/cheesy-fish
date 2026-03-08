extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D= $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_pressed("reset"):
		get_tree().reload_current_scene()
		Engine.time_scale = 1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#Get the input direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	#Flip Sprite
	if  direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	if direction:
		velocity.x = direction * SPEED
		

	#play animations
	
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

#ColdMeter
signal cold_changed(current_cold: float)

@export var max_cold: float = 100
@export var cold_increase_rate: float = 5.0 #freeze/sec
@export var warm_rate: float = 15.0 #faster than speed

var current_cold: float = 0.0
var is_near_fire: bool = false #safezone tracker
var is_dead: bool = false

@onready var timer: Timer = $Timer

func _process(delta: float):
	if is_dead:
		return
	#near fire check
	if is_near_fire:
		current_cold -= warm_rate * delta
	else:
		# Increase the cold over time using delta (time since last frame)
		current_cold += cold_increase_rate * delta
	
	# Clamp prevents the cold from going below 0 or above max_cold
	current_cold = clamp(current_cold, 0.0, max_cold)
	
	# Emit the signal so the UI knows to update!
	cold_changed.emit(current_cold)
	
	# Check for freezing condition
	if current_cold >= max_cold:
		freeze_to_death()

func freeze_to_death():
	is_dead = true
	print("The player froze!")
	Engine.time_scale = 0.5
	timer.start()
	

func _on_timer_timeout() -> void:
	Engine.time_scale = 1 
	get_tree().reload_current_scene()
	
