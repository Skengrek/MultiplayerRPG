extends Area2D

export var speed:int = 250
export var cooldown:float = 1.0
export var damage:int = 5

var modifier = {'effect': 'speed', 'value':-10, 'duration': 10}
var canCast = true
var direction = Vector2.ZERO

func shoot(newDirection, globalPosition):
	visible = true
	direction = newDirection
	$Sprite.rotation_degrees = atan2(newDirection.y, newDirection.x) * 180 / PI
	global_position = globalPosition
	$AnimationPlayer.play('Fired')
	
	$Cooldown.wait_time = cooldown
	$Cooldown.start()
	canCast = false
	

func _process(delta):
	var _moved = translate(speed*delta*direction)


func _on_IceSpear_body_entered(body):
	if body.has_method("processDamage"):
		body.processDamage(damage, modifier)
		queue_free()


func _on_Cooldown_timeout():
	canCast = true
