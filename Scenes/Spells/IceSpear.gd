extends Node2D

export var speed:int = 500
export var cooldown:float = 1.0
export var damage:int = 5

var modifier = {'effect': 'speed', 'value':-10, 'duration': 10}

var projectile = load("res://Scenes/Spells/IceSpearProjectile.tscn")

func cast(newDirection, globalPosition, scene):
	var data = {'speed':speed, 'damage':damage, 'modifier':modifier}
	var midAngle = atan2(newDirection.y, newDirection.x) * 180 / PI
	for i in [-20, -10, 0, 10, 20]:
		var newProj2 = projectile.instance()
		var newAngle = (midAngle-i)*PI/180
		newProj2.cast(Vector2(cos(newAngle), sin(newAngle)),
		globalPosition, data)
		scene.add_child(newProj2)
