extends Node

var level = 0
var levels = []


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
    levels.append(preload("res://Scenes/World/PrimeiroWorld.tscn"))
    levels.append(preload("res://Scenes/Tests/WorldTesteManeiro.tscn"))
    
    test_level()
    
func _process(delta):
    if Input.is_action_just_released("ui_focus_next"):
        next_level()
    
func test_level():
    for node in get_children():
        node.queue_free()
    add_child(levels[level].instance())

func next_level():
    level += 1
    if level >= levels.size():
        level = 0
        
    for node in get_children():
        node.queue_free()
    add_child(levels[level].instance())

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
