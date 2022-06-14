extends Area2D

export var speed:int = 800
export var cooldown = 0.5

var damage = 10

var direction = Vector2.ZERO

func shoot(newDirection, globalPosition):
	visible = true
	direction = newDirection
	global_position = globalPosition
	$AnimationPlayer.play('Fired')
	
func _process(delta):
	var _moved = translate(speed*delta*direction)


func _on_GrassBlade_body_entered(body):
	if body.has_method("processDamage"):
		body.processDamage(5)
		queue_free()
