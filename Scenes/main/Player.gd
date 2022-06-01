extends KinematicBody2D

# Variables ####################################################################
# General
var doProcessInput = true

# Movement
export var speed:int = 200
var velocity = Vector2.ZERO
var canDash = true
var dashModifier = 3

# Life & state
var hp = 4
var invulnerable = false
enum State {walking, dashing, stun, dead}
var state = State.walking

# Spells
export (Array, PackedScene) var SpellDeck
export (Array, bool) var SpellCD

# Ready ########################################################################
func _ready():
	addSpell("res://Scenes/Spells/GrassBlade.tscn")


# Process ######################################################################
func _process(_delta):
	if doProcessInput:
		processInput()
	if not state in [State.stun, State.dead]:
		var _moved = move_and_slide(velocity)
	
	if invulnerable:
		$ColorRect.color = '#ffffff'
	else:
		$ColorRect.color = '#4ded0c'


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
	
	if Input.is_action_pressed("spell1"):
		useSpell(0)
			
	velocity = velocity.normalized() * speed

# Spells #######################################################################
func addSpell(scenePath):
	SpellDeck.append(load(scenePath))
	SpellCD.append(true)

func useSpell(id):
	if SpellCD[id]:
			var newSpell = SpellDeck[id].instance()
			newSpell.shoot(defineDirectionOfSpell(), global_position)
			get_parent().add_child(newSpell)
			SpellCD[0] = false
			$Timers/Spell1Cooldown.start(newSpell.cooldown)


func defineDirectionOfSpell():
	var newDirection = get_viewport().get_mouse_position() - position 
	return newDirection.normalized()

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


func _on_Spell1Cooldown_timeout():
	SpellCD[0] = true
