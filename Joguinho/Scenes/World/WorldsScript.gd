extends Node2D

onready var retroShader = $CanvasLayer/ColorRect
onready var timerFase = $ObjectiveTimer
onready var player = $Character

func _ready():
    pass

func _process(delta):
    pass
    
func _on_ObjectiveTimer_timeout():
    finish_game_defeat()

func finish_game_defeat():
    pass
    
func finish_game_win():
    pass

func _on_ObjectiveArea_body_entered(body):
    final_part_reached()

func final_part_reached():
    pass