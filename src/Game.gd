extends Node

@onready var path: Path2D = $PathContainer/Path2D
@onready var line: Line2D =  $PathContainer/Line2D
@onready var hud: HUD = $Camera2D/HUD
@onready var slotController: SlotController = $SlotContainer
@onready var enemyController: Node2D = $EnemyContainer
@onready var enemypacked: PackedScene = preload("res://scenes/entity/Enemy.tscn")
	
var r: Vector2 = Vector2.RIGHT
var l: Vector2 = Vector2.LEFT
var u: Vector2 = Vector2.UP
var d: Vector2 = Vector2.DOWN

var multiplier = 50.0
var speed = 100.0
var distance = 0.0
var curr_path: Array[Vector2] = [Vector2.ZERO]
var queue = 0:
	set(v):
		hud.set_queue(v)
		queue = v
var next_queue = 0:
	set(v):
		hud.set_next_queue(v)
		next_queue = v
var lvl = 0
var reload_time = 5.0
var time = 5.0

func _ready():
	next_queue = randi() % 10

func spawn(speed):
	var enemy: Enemy = enemypacked.instantiate()
	enemy.path = path 
	enemy.speed = speed
	enemyController.add_child(enemy)
	
func differentFrom(direction: Vector2):
	return curr_path[len(curr_path) - 1] != direction if len(curr_path) > 0 else true

var debounced = []
func inputDebouncer(action: String, condition: bool, callback: Callable, timeout: float = 0.25):
	var idx = debounced.find(action)
	if condition:
		if idx == -1:			
			debounced.append(action)
			callback.call()
			get_tree().create_timer(timeout).connect('timeout', 
				func():
					var _idx = debounced.find(action)
					if _idx != -1:
						debounced.remove_at(_idx)
					#print('remove ', action,' at ',_idx)
			)
			return true
	elif idx != -1:
		debounced.remove_at(idx)
	return false
			
func checkInput():
	var path_len = len(curr_path)
	if inputDebouncer('spawn', Input.is_action_pressed("space"), spawn): pass
	if inputDebouncer('ui_left', Input.is_action_pressed('ui_left') and !debounced.has('ui_right') and !debounced.has('ui_up') and !debounced.has('ui_down'),
		func(): if differentFrom(r): curr_path.append(l) else: curr_path.remove_at(len(curr_path) -1)
	): pass
	elif inputDebouncer('ui_right', Input.is_action_pressed('ui_right') and !debounced.has('ui_left') and !debounced.has('ui_up') and !debounced.has('ui_down'),
		func(): if differentFrom(l): curr_path.append(r) else: curr_path.remove_at(len(curr_path) -1)
	): pass
	elif inputDebouncer('ui_up', Input.is_action_pressed('ui_up') and !debounced.has('ui_right') and !debounced.has('ui_left') and !debounced.has('ui_down'),
		func(): if differentFrom(d): curr_path.append(u) else: curr_path.remove_at(len(curr_path) -1)
	): pass
	elif inputDebouncer('ui_down', Input.is_action_pressed('ui_down') and !debounced.has('ui_right') and !debounced.has('ui_up') and !debounced.has('ui_left'),
		func(): if differentFrom(u): curr_path.append(d) else: curr_path.remove_at(len(curr_path) -1)
	): pass
	elif inputDebouncer('ui_cancel', Input.is_action_pressed('ui_cancel'),
		func(): 
			if len(curr_path) > 0:
				curr_path.remove_at(len(curr_path) -1)
	): pass
	if path_len!= len(curr_path):
		createPath(curr_path)
		#hud.set_path(curr_path_s.reduce(func(a, path): return a + path, ''))	
		hud.set_path(len(curr_path))	
	
func _process(d):
	checkInput()
	if len(line.points) > 1:
		var totalDistance = path.curve.get_baked_length()
		hud.set_total_distance('%.2f' % totalDistance)
	else:
		hud.set_total_distance('%.2f' % 0)
		

func getPoint(idx = -1):
	if path.curve.point_count >= abs(idx):
		return path.curve.get_point_position(path.curve.point_count + idx)
	return Vector2.ZERO
	
func createPath(dirs: Array[Vector2]):
	#path.curve.add_point(Vector2.ZERO)
	path.curve.clear_points()
	line.clear_points()
	var points = []
	for i in len(dirs):
		var dir: Vector2 = dirs[i]
		var lastpoint = getPoint(-1)
		var l_dir = dirs[i - 1] if i > 0 else Vector2.ZERO
		var f_dir = dir
		if l_dir != dir:
			f_dir = dir + l_dir			
		var m_dir = f_dir * multiplier
		var point = (lastpoint + m_dir)
		var pre_out = l_dir*.55*multiplier
		var curr_in = -dir*.55*multiplier
		if path.curve.point_count > 0:
			path.curve.set_point_out(path.curve.point_count -1, pre_out)
		path.curve.add_point(
			point, 
			curr_in
		)
		points.append(point)
	path.curve.bake_interval = 10
	line.points = path.curve.get_baked_points()
	slotController.updateSlot(points, line.points, multiplier)

func emitWave():
	queue = next_queue
	next_queue = randi() % 10 + lvl	
	var speed = ((randi() % 10) + 1) * 10
	for i in queue:
		spawn(speed)
		await get_tree().create_timer(.5).timeout
	pass # Replace with function body.


func _on_timer_timeout():
	time -= 1
	hud.set_time(time)
	if time == 0:
		time = reload_time
		emitWave()
