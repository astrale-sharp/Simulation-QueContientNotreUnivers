extends TabContainer



onready var consignes = $Consignes
var bravo_scn = preload("res://Bravo.tscn").instance()


func _ready() -> void:
	$"connecter les cartes".connect("finished",self,"on_finished")

func on_finished():
	add_child(bravo_scn)
	set_current_tab(get_tab_count()-1)
