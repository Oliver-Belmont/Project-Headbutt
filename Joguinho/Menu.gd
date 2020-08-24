extends Node

var paused = false
var title = preload("res://Scenes/Newspapper/Title_Screen/Title_Screen.tscn")
var win = preload("res://Scenes/Newspapper/Newspapper.tscn")
var lose = preload("res://Scenes/Newspapper/News_bad_ending.tscn")
var credits = preload("res://Scenes/Newspapper/Credits.tscn")

onready var levelSelector = get_parent().get_node("LevelSelector")

func _ready():
    title_screen()

func _process(delta):
    if Input.is_action_just_pressed("ui_cancel"):
        if paused:
            $PauseLayer/Popup.hide()
            get_tree().paused = false
            paused = false
        else:
            $PauseLayer/Popup.show()
            get_tree().paused = true
            paused = true   
    #if Input.is_action_just_pressed("ui_accept"):
    #    title_screen()

func clear_newspapers():
    for node in $Newspaper.get_children():
        node.queue_free()
            
func title_screen():
    var screen = title.instance()
    $Newspaper.add_child(screen)

func win_screen():
    clear_newspapers()
    var screen = win.instance()
    $Newspaper.add_child(screen)

func lose_screen():
    clear_newspapers()
    var screen = lose.instance()
    $Newspaper.add_child(screen)

func start_game():
    clear_newspapers()
    levelSelector.start_game()

func next_stage():
    clear_newspapers()
    levelSelector.next_level()

func retry_stage():
    clear_newspapers()
    levelSelector.retry_level()

func back_to_title():
    levelSelector.clear_level()
    clear_newspapers()
    title_screen()

func show_credits():
    clear_newspapers()
    var screen = credits.instance()
    $Newspaper.add_child(screen)

func show_guide():
    $PauseLayer/Guide.show()

func hide_guide():
    $PauseLayer/Guide.hide()

func quit_game():
    get_tree().quit()