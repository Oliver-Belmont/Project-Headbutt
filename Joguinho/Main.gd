extends Node

func _ready():
    pass # Replace with function body.

func main_game_defeat():
    get_tree().paused = true
    $Menu.lose_screen()
    
func main_game_win():
    get_tree().paused = true
    $Menu.win_screen()

