extends KinematicBody2D

export var life:int = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	
func processDamage(damage):
	$Anim.stop()
	$Anim.play("TakeDamage")
	pass
