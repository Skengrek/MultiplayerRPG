extends Node

class_name Class

var stats : CharStats
onready var skills = $Skills

export var startingStats: Resource
export(Array) var skillSet
export(PackedScene) var character_skill_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	stats = CharStats.new(startingStats)
	if skillSet != null and skillSet.size() > 0:
		for skill in skillSet:
			var newSkill = character_skill_scene.instance()
			newSkill.initialize(skill)
			skills.add_child(newSkill)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
