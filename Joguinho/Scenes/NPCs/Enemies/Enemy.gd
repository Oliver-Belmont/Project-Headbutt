extends KinematicBody2D

const GRAVITY = 4000.0
const WALK_SPEED = 50.0
const RUN_SPEED = 200.0
const JUMP_FORCE = 1000.0

var horizontalSpeed
var velocity = Vector2()
# 1 = right, -1 = left
var direction = 1
var leftArea
var rightArea

func _ready():
    horizontalSpeed = WALK_SPEED
    $Timer.start()
    velocity.y = 0
    leftArea = $Left
    rightArea = $Right
    leftArea.set_process(false)
    
func _physics_process(delta):    
    if !is_on_floor():
        velocity.y += delta * GRAVITY

    velocity.x = direction * horizontalSpeed
    # Move the character
    move_and_slide(velocity, Vector2(0, -1))

func switchDirection():
    direction = direction * -1

func _on_Timer_timeout():
    switchDirection()
    $Timer.wait_time = randi() % 3 + 3
    $Timer.start()


func _on_Left_body_entered(body):
    if(body.is_in_group("player")):
        $Timer.stop()
        direction = -1
        horizontalSpeed = RUN_SPEED


func _on_Right_body_entered(body):
    if(body.is_in_group("player")):
        $Timer.stop()
        direction = 1
        horizontalSpeed = RUN_SPEED

func _on_Left_body_exited(body):
    if(body.is_in_group("player")):
        horizontalSpeed = WALK_SPEED
        $Timer.start()


func _on_Right_body_exited(body):
    if(body.is_in_group("player")):
        horizontalSpeed = WALK_SPEED
        $Timer.start()

