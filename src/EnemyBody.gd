extends Node2D
class_name EnemyBody

@onready var life_rect = $CanvasLayer/Control/LifeRect
@onready var dmg_rect = $CanvasLayer/Control/DmgRect
var enemy: Enemy

func _ready():
	dmg_rect.scale.x = 0

func _process(d):
	$CanvasLayer/Control.global_position = global_position

func get_enemy():
	return enemy

func draw_life(life, max_life):
	if life == 0.0:
		dmg_rect.scale.x = 1
	else:
		var perc = 1.0 - ((max_life * life) / life_rect.size.x)
		dmg_rect.scale.x = perc
