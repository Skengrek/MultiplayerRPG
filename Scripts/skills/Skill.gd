extends Resource

class_name Skill

export var skill_name:String = "Skill"
export var skill_description:String = ""

export var cost:int
export var base_damage:int
export (int, 0, 100) var critic_rate:float
