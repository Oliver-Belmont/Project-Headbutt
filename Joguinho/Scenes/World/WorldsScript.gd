extends Node2D

onready var retroShader = $CanvasLayer/ColorRect
onready var timerFase = $ObjectiveTimer
onready var player = $Character
onready var main = get_tree().get_root().get_node("Main")

export(int) var objDuration = 30

func _ready():
    player.connect("player_death", self, "finish_game_defeat")
    toggle_no_change()
    $ObjectiveTimer.wait_time = objDuration
    $ObjectiveTimer.start()

func toggle_no_change():
    if (!get_parent().retro_toggle):
        $CanvasLayer/ColorRect.hide()
    elif (get_parent().retro_toggle):
        $CanvasLayer/ColorRect.show()

func toggle_retro_screen():
    if (get_parent().retro_toggle):
        $CanvasLayer/ColorRect.hide()
        get_parent().retro_toggle = false
    elif (!get_parent().retro_toggle):
        $CanvasLayer/ColorRect.show()
        get_parent().retro_toggle = true        

func _process(delta):
    if Input.is_action_just_pressed("ui_retro"):
        toggle_retro_screen()
    
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
    