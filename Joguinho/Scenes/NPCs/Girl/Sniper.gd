extends RigidBody2D

var wasHit = false

func _ready():
    self.connect("body_entered", self, "was_hit")
    $Sprite.flip_h = true
    $Sprite/AnimationPlayer.play("aim_state")

func was_hit(body):
    if body.is_in_group("player") && wasHit == false:
        wasHit = true
        print("Sniper was hit! The president is safe!")
        body.dive_over("sniper")
        
func shoot_animation():
    get_tree().paused = true
    Engine.time_scale = 0.2
    $Sprite/AnimationPlayer.play("shoot")
    yield(get_node("Sprite/AnimationPlayer"), "animation_finished")
    Engine.time_scale = 1.0
    get_tree().paused = false
    get_parent().get_parent().finish_game_defeat()