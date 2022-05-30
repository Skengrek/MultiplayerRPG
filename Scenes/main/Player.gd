extends KinematicBody2D

# Variables ####################################################################
# Movement
export var speed:int = 200
var velocity = Vector2.ZERO
var canDash = true
var dashModifier = 3

# Life & state
var hp = 4
var invulnerable = false
enum State {walking, dashing, dead}
var state = State.walking


func _ready():
	pass # Replace with function body.


# Process ######################################################################
func _process(_delta):
	processInput()
	move_and_slide(velocity)
	
	if invulnerable:
		$ColorRect.color = '#ffffff'
	else:
		$ColorRect.color = '#cd0a0a'


# Inputs  ######################################################################
func processInput():
	if state == State.walking:
		velocity = Vector2()
		if Input.is_action_pressed("ui_right"):
			velocity.x += 1
		if Input.is_action_pressed("ui_left"):
			velocity.x -= 1
		if Input.is_action_pressed("ui_down"):
			velocity.y += 1
		if Input.is_action_pressed("ui_up"):
			velocity.y -= 1
			
	if Input.is_action_pressed("dash"):
		if canDash:
			startDash()
			
	velocity = velocity.normalized() * speed


# Damages ######################################################################
func processDamages(damages):
	if not invulnerable:
		# Process damages
		hp -= damages
		if hp <= 0:
			state = State.dead


# Dashing ######################################################################
func startDash():
	state = State.dashing
	canDash = false
	invulnerable = true
	speed *= dashModifier
	$Timers/DashDuration.start()
	$Timers/DashCooldown.start()


# Slots ########################################################################
func _on_DashDuration_timeout():
	state = State.walking
	speed /= dashModifier
	invulnerable = false


func _on_DashCooldown_timeout():
	canDash = true
