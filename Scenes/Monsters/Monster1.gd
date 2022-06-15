extends KinematicBody2D

export var life:int = 20
export var speed:int = 200

var timeSpent = 0

var effectParticle = {
	'slow':preload("res://Assets/Effects/slow.tscn")
}

var modifier = {'speed': {'value':0,'duration':0},
				'damage': {'value':0,'duration':0},
				'resistance': {'value':0,'duration':0}}


func _ready():
	effectParticle['slow'] = effectParticle['slow'].instance()
	effectParticle['slow'].visible = false
	$Anim.play('Iddle')

func _process(delta):
	timeSpent += delta
	var _speed = speed * modifier['speed']['value']/100
	if modifier['speed']['value'] < 0:
		modifier['speed']['duration'] -= delta
		if modifier['speed']['duration'] <= 0:
			modifier['speed']['value'] = 0
	else:
		effectParticle['slow'].visible = false
	
	if timeSpent >= 5:
		$Anim.play('Jump')
	
func processDamage(damage, spellModif=null):
	$Anim.stop()
	$Anim.play("TakeDamage")
	if spellModif:
		modifier[spellModif['effect']]['value'] = spellModif['value']
		modifier[spellModif['effect']]['duration'] = float(spellModif['duration'])
	life -= damage
	if life <= 0:
		death()

func death():
	queue_free()
