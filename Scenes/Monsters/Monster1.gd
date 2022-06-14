extends KinematicBody2D

export var life:int = 10
export var speed:int = 200

var effectParticle = {
	'slow':preload("res://Assets/Effects/slow.tscn")
}

var modifier = {'speed': {'value':0,'duration':0},
				'damage': {'value':0,'duration':0},
				'resistance': {'value':0,'duration':0}}


func _ready():
	effectParticle['slow'] = effectParticle['slow'].instance()
	effectParticle['slow'].visible = false

func _process(delta):
	var _speed = speed * modifier['speed']['value']/100
	print(modifier['speed']['value'])
	if modifier['speed']['value'] < 0:
		modifier['speed']['duration'] -= delta
		if modifier['speed']['duration'] <= 0:
			modifier['speed']['value'] = 0
	else:
		effectParticle['slow'].visible = false
	
func processDamage(damage, spellModif=null):
	$Anim.stop()
	$Anim.play("TakeDamage")
	if spellModif:
		modifier[spellModif['effect']]['value'] = spellModif['value']
		modifier[spellModif['effect']]['duration'] = float(spellModif['duration'])
