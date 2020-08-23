extends Node2D

onready var retroShader = $CanvasLayer/ColorRect
onready var timerFase = $ObjectiveTimer
onready var player = $Character

func _ready():
    pass

func _process(delta):
    pass
    
func _on_ObjectiveTimer_timeout():
    finish_game()

func finish_game():
    pass