extends Area2D

var speed = null
var damage = null

var direction = Vector2.ZERO

	
func _process(delta):
	if speed:
		translate(speed*delta*direction.normalized())


func cast(newDirection, globalPosition, data):
	speed = data['speed']
	damage = data['damage']
	visible = true
	direction = newDirection
	global_position = globalPosition
	$AnimationPlayer.play('Fired')

func _on_Area2D_body_entered(body):
	if body.has_method("processDamage"):
		body.processDamage(damage)
		queue_free()
