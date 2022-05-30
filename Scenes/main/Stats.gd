extends Node

class_name CharStats

signal healthChanged(new_health)
signal healtDepleted()

var modifier = {}

var health:int
var mana:int
var maxHealth:int
var maxMana:int
var strength:int
var intelligence:int
var agility:int
var defense:int
var speed:int

func initialize(stats: BaseStats):
	maxHealth = stats.maxHealth
	maxMana = stats.maxMana
	strength = stats.strength
	intelligence = stats.intelligence
	agility = stats.agility
	defense = stats.defense
	speed = stats.speed

func setMaxHealth(value):
	maxHealth = max(0, value)
	
func setMaxMana(value):
	maxMana = max(0, value)
	
func takeDamage(hit):
	health -= hit.damage
	emit_signal("healthChanged", health)
	if health <= 0:
		emit_signal("healthDepleted")
		
func heal(amount):
	health += amount
	health = max(health, maxHealth)
	emit_signal("healthChanged", health)
	
func addModifier(id, modifier):
	modifier[id] = modifier
	
func removeModifier(id):
	modifier.erase(id)


func _init(newStats):
	initialize(newStats)
