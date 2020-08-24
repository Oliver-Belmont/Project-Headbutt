extends Node2D

onready var retroShader = $CanvasLayer/ColorRect
onready var timerFase = $ObjectiveTimer
onready var player = $Character
onready var main = get_tree().get_root().get_node("Main")

export(int) var objDuration = 30

func _ready():
    player.connect("player_death", self, "finish_game_defeat")
    $ObjectiveTimer.wait_time = objDuration
    $ObjectiveTimer.start()

func _process(delta):
    pass
    
func _on_ObjectiveTimer_timeout():
    $FinalCloseCamera.set_current()
    $Enemies/Girl.shoot_animation()

func finish_game_defeat():
    main.main_game_defeat()
    
func finish_game_win():
    main.main_game_win()

func _on_ObjectiveArea_body_entered(body):
    if(body.is_in_group("player")):
        final_part_reached()

func final_part_reached():
    player.hero_moment()
    
func show_dive_guide():
    main.get_node("Menu").show_guide()
    
func hide_dive_guide():
    main.get_node("Menu").hide_guide()
    