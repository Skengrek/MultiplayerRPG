extends Area2D

export var speed:int = 250
export var cooldown = 1

var damage = 5

var direction = Vector2.ZERO

func shoot(newDirection, globalPosition):
	visible = true
	direction = newDirection
	$Sprite.rotation_degrees = atan2(newDirection.y, newDirection.x)
	global_position = globalPosition
	$AnimationPlayer.play('Fired')
	

func _process(delta):
	var _moved = translate(speed*delta*direction)
