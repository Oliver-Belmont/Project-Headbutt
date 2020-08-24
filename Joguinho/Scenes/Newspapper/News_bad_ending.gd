extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
    $AnimationPlayer.play("spinning_entrance")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass


func _on_ExitButton_button_up():
    get_parent().get_parent().back_to_title()


func _on_RetryButton_button_up():
    get_parent().get_parent().retry_stage()
