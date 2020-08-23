extends Node

var paused = false

func _ready():
    pass # Replace with function body.

func _process(delta):
    if Input.is_action_just_pressed("ui_cancel"):
        if paused:
            $CanvasLayer/Popup.hide()
            get_tree().paused = false
            paused = false
        else:
            $CanvasLayer/Popup.show()
            get_tree().paused = true
            paused = true
            
