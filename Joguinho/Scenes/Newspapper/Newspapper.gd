extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
    $AnimationPlayer.play("spinning_entrance")


func _on_NextButton_button_up():
    get_parent().get_parent().next_stage()


func _on_BackToTitleButton_button_up():
    get_parent().get_parent().back_to_title()
