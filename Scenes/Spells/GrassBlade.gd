extends Area2D

export var speed:int = 400
export var cooldown = 0.5

var canCast = true
var damage = 10

var direction = Vector2.ZERO

func shoot(newDirection, globalPosition):
	visible = true
	direction = newDirection
	global_position = globalPosition
	$AnimationPlayer.play('Fired')
	$Cooldown.wait_time = cooldown
	$Cooldown.start()
	canCast = false
	
func _process(delta):
	var _moved = translate(speed*delta*direction)


func _on_GrassBlade_body_entered(body):
	if body.has_method("processDamage"):
		body.processDamage(damage)
		queue_free()


func _on_Cooldown_timeout():
	canCast = true
