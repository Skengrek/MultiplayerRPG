extends Node2D

export var speed:int = 500
export var cooldown = 0.5
export var maxDistance = 1000

var damage = 10
var projectile = load("res://Scenes/Spells/grassBladeProjectile.tscn")

func cast(newDirection, globalPosition, scene):
	var newProj = projectile.instance()
	newProj.cast(newDirection, globalPosition, {'speed':speed, 'damage':damage})
	scene.add_child(newProj)
