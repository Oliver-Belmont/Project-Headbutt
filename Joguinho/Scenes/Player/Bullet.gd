extends KinematicBody2D

const HORIZONTAL_SPEED = 1800.0

var velocity = Vector2()

func _ready():
    # velocity.x = HORIZONTAL_SPEED
    velocity.y = 0

func _physics_process(delta):
    # We don't need to multiply velocity by delta because "move_and_slide" already takes delta time into account.

    # The second parameter of "move_and_slide" is the normal pointing up.
    # In the case of a 2D platformer, in Godot, upward is negative y, which translates to -1 as a normal.
    move_and_slide(velocity, Vector2(0, -1))
    
func set_direction(direction):
    if (direction == "left"):
        velocity.x = -HORIZONTAL_SPEED
    elif (direction == "right"):
        velocity.x = HORIZONTAL_SPEED