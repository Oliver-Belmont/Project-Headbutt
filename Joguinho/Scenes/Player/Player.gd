extends KinematicBody2D

const BulletResource = preload("res://Scenes/Player/Bullet.tscn")

var GRAVITY = 4000.0
const WALK_SPEED = 500.0
const JUMP_FORCE = 1000.0

onready var worldNode = get_parent()

# 1 = right, -1 = left
var last_direction = 1
var baseHVelocity
var velocity = Vector2()
var velocityModulation = 1
var isFlipped = false
var isCrouched = false
var isSliding = false
var game_over = false
var emitted = false
var canEmitt = false
var its_head_time = false
var leap_of_faith = false
var already_hit = false
var diveResult
var lerp_decay = 6.0

signal player_death

func _ready():
    $Camera2D.current = true

func _physics_process(delta):
    if (!game_over):
        handle_input()
        # Incresce or reduce the horizontal velocity based on the input
        velocity.x = baseHVelocity * velocityModulation
    elif game_over:
        velocity.x = lerp(velocity.x, 0, delta * lerp_decay)
        if (abs(velocity.x) <= 1 && !emitted):
            if(canEmitt):
                emit_signal("player_death")
                emitted = true
            $Camera2D.zoom_out_death()
            Engine.time_scale = 1.0
    
    if !is_on_floor():
        velocity.y += delta * GRAVITY
        if (leap_of_faith):
            if (velocity.y > 0):
                GRAVITY = 100
            elif (velocity.y < 0):
                velocity.y = 0
                GRAVITY = 0
    
    if (!leap_of_faith && already_hit):
        velocity.x = lerp(velocity.x, 0, delta * lerp_decay)
        

    # Move the character
    move_and_slide(velocity, Vector2(0, -1))
  

func hero_moment():
    its_head_time = true
    baseHVelocity = 0
    $Sprite/AnimationPlayer.play("idle")
    $Camera2D.zoom_hero_moment()
    worldNode.show_dive_guide()

func player_dive():
    leap_of_faith = true
    GRAVITY = 100
    baseHVelocity = 1000.0
    velocity.y = -10
    $CollisionShape2D.scale.y = 0.5
    $Sprite/AnimationPlayer.play("rescue_dive")
    $Camera2D.zoom_dive_moment()
    Engine.time_scale = 0.1
    worldNode.hide_dive_guide()
    
func dive_over(result):
    leap_of_faith = false
    GRAVITY = 4000.0
    lerp_decay = 60
    Engine.time_scale = 1.0
    diveResult = result
    $Camera2D.zoom_dive_over()
    worldNode.get_node("ObjectiveTimer").stop()
    $LeapTimer.start()
    
  
func handle_input():
    if(its_head_time):
        if Input.is_action_just_pressed("ui_dive"):
            player_dive()
    else:
        if(!isSliding):
            # Horizontal input
            if Input.is_action_pressed("ui_left"):
                baseHVelocity = -WALK_SPEED
                if (!isFlipped):
                    $Sprite.flip_h = true
                if (is_on_floor()):
                    $Sprite/AnimationPlayer.play("run")
                isFlipped = true
                last_direction = -1
            elif Input.is_action_pressed("ui_right"):
                baseHVelocity =  WALK_SPEED
                if (isFlipped):
                    $Sprite.flip_h = false
                if (is_on_floor()):
                    $Sprite/AnimationPlayer.play("run")
                isFlipped = false
                last_direction = 1
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
        if Input.is_action_just_pressed("ui_slide") && is_on_floor() && velocity.x != 0 && !isSliding:
            $Sprite/AnimationPlayer.play("slide")
            # Stop colliding when sliding
            isSliding = true
            $Camera2D.slide_zoom_in()
            self.set_collision_layer(2)
            self.set_collision_mask(2)
            $CollisionShape2D.scale.y = 0.5
            $CollisionShape2D.position.y += 12.5
            # Wait for the animation to finish
            yield(get_node("Sprite/AnimationPlayer"), "animation_finished")
            # Restore its behaviour after the slide
            isSliding = false
            $Camera2D.reset_zoom()
            self.set_collision_layer(1)
            self.set_collision_mask(1)
            $CollisionShape2D.scale.y = 1.0
            $CollisionShape2D.position.y -= 12.5

                

func shoot(direction):
    var offset
    # Instance a new bullet
    var bullet = BulletResource.instance()
    # Set bullet direction and starting position 
    bullet.set_direction(direction)
    bullet.transform = self.transform
    offset = Vector2(40*direction, 0)
    bullet.translate(offset)
    # Add to world
    worldNode.add_child(bullet)
    
func take_damage(direction):
    if (!game_over):
        game_over = true
        if direction == 1:
            $Sprite.flip_h = true
            $Sprite/AnimationPlayer.play("death_left")
        elif direction == -1:
            $Sprite.flip_h = false
            $Sprite/AnimationPlayer.play("death")
        velocity.x = WALK_SPEED * direction
        velocity.y = -JUMP_FORCE / 2
        Engine.time_scale = 0.2
        $Camera2D.zoom_in_death()
        $DeathTimer.start()
        

func _on_DeathTimer_timeout():
    canEmitt = true

func _on_LeapTimer_timeout():
    if (diveResult == "president"):
        get_parent().finish_game_win()
    elif (diveResult == "sniper"):
        get_parent().finish_game_win()
