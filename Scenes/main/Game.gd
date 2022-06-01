extends Node2D

onready var monster1 = preload("res://Scenes/Monsters/Monster1.tscn")

func _ready():
	var monster = monster1.instance()
	monster.position = Vector2(100, 100)
	get_parent().call_deferred('add_child', monster)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
