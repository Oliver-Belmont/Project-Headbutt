extends KinematicBody2D

export var finalPos = 100
export var duration = 15

var velocity = Vector2()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
    velocity.x = 0
    velocity.y = (finalPos - self.position.y)/duration

func _physics_process(delta):
    move_and_slide(velocity, Vector2(0, -1))
    

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
