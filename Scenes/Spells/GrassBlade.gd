extends Node2D

export var speed:int = 800
export var cooldown = 0.5

var damage = 10
var projectile = load("res://Scenes/Spells/grassBladeProjectile.tscn")

func cast(newDirection, globalPosition, scene):
	var newProj = projectile.instance()
	newProj.cast(newDirection, globalPosition, {'speed':speed, 'damage':damage})
	scene.add_child(newProj)
