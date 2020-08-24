extends Node

var level = 0
var levels = []

# Called when the node enters the scene tree for the first time.
func _ready():
    levels.append(preload("res://Scenes/World/PrimeiroWorld.tscn"))
    levels.append(preload("res://Scenes/World/SegundoWorld.tscn"))
    levels.append(preload("res://Scenes/World/TerceiroWorld.tscn"))
    #levels.append(preload("res://Scenes/Tests/WorldTesteManeiro.tscn"))
    #levels.append(preload("res://Scenes/Tests/test1.tscn"))
    
    #clear_level()
    #play_this_level()
    
func _process(delta):
    #if Input.is_action_just_released("ui_focus_next"):
    #    next_level()
    pass
    
func start_game():
    level = 0
    clear_level()
    play_this_level()

func play_this_level():
    add_child(levels[level].instance())
    get_tree().paused = false

func clear_level():
    for node in get_children():
        node.queue_free()

func next_level():
    level += 1
    if level >= levels.size():
        level = 0
    clear_level()
    play_this_level()
    
func retry_level():
    clear_level()
    play_this_level()
