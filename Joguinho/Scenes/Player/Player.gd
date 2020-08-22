extends KinematicBody2D

const BulletResource = preload("res://Scenes/Player/Bullet.tscn")

const GRAVITY = 4000.0
const WALK_SPEED = 500.0
const JUMP_FORCE = 1000.0

var last_direction = "right"
var baseHVelocity
var velocity = Vector2()
var velocityModulation = 1
var isFlipped = false
var isCrouched = false
var isSliding = false

onready var worldNode = get_tree().get_root().get_node("World")

func _ready():
    $Camera2D.current = true

func _physics_process(delta):
    
    if !is_on_floor():
        velocity.y += delta * GRAVITY
    if(!isSliding):
        # Horizontal input
        if Input.is_action_pressed("ui_left"):
            baseHVelocity = -WALK_SPEED
            if (!isFlipped):
                $Sprite.flip_h = true
            if (is_on_floor()):
                $Sprite/AnimationPlayer.play("run")
            isFlipped = true
            last_direction = "left"
        elif Input.is_action_pressed("ui_right"):
            baseHVelocity =  WALK_SPEED
            if (isFlipped):
                $Sprite.flip_h = false
            if (is_on_floor()):
                $Sprite/AnimationPlayer.play("run")
            isFlipped = false
            last_direction = "right"
        else:
            if (is_on_floor()):
                $Sprite/AnimationPlayer.play("idle")
            baseHVelocity = 0
    
        # Jump input
        if Input.is_action_just_pressed("ui_up") && is_on_floor() && !isCrouched:
            $Sprite/AnimationPlayer.play("jump")
            velocity.y = -JUMP_FORCE
    
        # Crouch input
        if Input.is_action_pressed("ui_down") && is_on_floor():
            velocityModulation = 0
            isCrouched = true
            $Sprite/AnimationPlayer.play("crouch")
            
        # Reset speed when leaving crouch position
        if Input.is_action_just_released("ui_down"):
            velocityModulation = 1
            isCrouched = false
            
        
    # Shoot input
    if Input.is_action_just_pressed("ui_select"):
        shoot(last_direction)
    
    # Slide input
    if Input.is_action_just_released("ui_slide") && is_on_floor() && velocity.x != 0:
        $Sprite/AnimationPlayer.play("slide")
        isSliding = true
        $Camera2D.slideZoomIn()
        yield(get_node("Sprite/AnimationPlayer"), "animation_finished")
        isSliding = false
        $Camera2D.resetZoom()
                

    # Incresce or reduce the horizontal velocity based on the input
    velocity.x = baseHVelocity * velocityModulation

    # Move the character
    move_and_slide(velocity, Vector2(0, -1))
    

func shoot(direction):
    var offset
    # Instance a new bullet
    var bullet = BulletResource.instance()
   
    # Set bullet direction and starting position 
    bullet.set_direction(direction)
    bullet.transform = self.transform
    if (direction == "left"):
        offset = Vector2(-40, 0)
    elif (direction == "right"):
        offset = Vector2(40,0)
    bullet.translate(offset)
    
    # Add to world
    worldNode.add_child(bullet)
    
