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
        