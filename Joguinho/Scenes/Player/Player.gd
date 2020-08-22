extends KinematicBody2D

const BulletResource = preload("res://Scenes/Player/Bullet.tscn")

const GRAVITY = 4000.0
const WALK_SPEED = 500.0
const JUMP_FORCE = 1000.0

var last_direction = "right"
var velocity = Vector2()

onready var worldNode = get_tree().get_root().get_node("World")

func _physics_process(delta):
    
    if !is_on_floor():
        velocity.y += delta * GRAVITY

    if Input.is_action_pressed("ui_left"):
        velocity.x = -WALK_SPEED
        last_direction = "left"
    elif Input.is_action_pressed("ui_right"):
        velocity.x =  WALK_SPEED
        last_direction = "right"
    else:
        velocity.x = 0

    if Input.is_action_just_pressed("ui_up") && is_on_floor():
        velocity.y = -JUMP_FORCE
        
    if Input.is_action_just_pressed("ui_select"):
        shoot(last_direction)
    

    # We don't need to multiply velocity by delta because "move_and_slide" already takes delta time into account.

    # The second parameter of "move_and_slide" is the normal pointing up.
    # In the case of a 2D platformer, in Godot, upward is negative y, which translates to -1 as a normal.
    move_and_slide(velocity, Vector2(0, -1))
    

func shoot(direction):
    var offset
    var bullet = BulletResource.instance()
    
    bullet.set_direction(direction)
    bullet.transform = self.transform
    
    if (direction == "left"):
        offset = Vector2(-40, 0)
    elif (direction == "right"):
        offset = Vector2(40,0)
    bullet.translate(offset)
    worldNode.add_child(bullet)
    
