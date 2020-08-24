extends Node2D


func _ready():
    $AnimationPlayer.play("spinning_entrance")

func _on_ExitButton_button_up():
    get_parent().get_parent().quit_game()

func _on_StartButton_button_up():
    get_parent().get_parent().start_game()
