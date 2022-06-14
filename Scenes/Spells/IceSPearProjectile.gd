extends Area2D

var direction = Vector2.ZERO

var speed = null
var damage = null
var modifier = null

func cast(newDirection, globalPosition, data):
	speed = data['speed']
	damage = data['damage']
	modifier = data['modifier']
	visible = true
	direction = newDirection
	$Sprite.rotation_degrees = atan2(newDirection.y, newDirection.x) * 180 / PI
	global_position = globalPosition
	$AnimationPlayer.play('Fired')


func _process(delta):
	if speed:
		translate(speed*delta*direction.normalized())


func _on_projectile_body_entered(body):
	if body.has_method("processDamage"):
		body.processDamage(damage, modifier)
	queue_free()
