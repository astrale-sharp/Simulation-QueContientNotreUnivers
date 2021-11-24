extends GraphEdit


var img_paths = [
	"res://assets/scaled_down/A8-0.png",
	"res://assets/scaled_down/A8-1.png",
	"res://assets/scaled_down/A8-2.png",
	"res://assets/scaled_down/A8-3.png",
	"res://assets/scaled_down/A8-4.png",
	"res://assets/scaled_down/A8-5.png",
	"res://assets/scaled_down/A8-6.png",
	"res://assets/scaled_down/A8-7.png",
]

onready var validate_button = $"../HBoxContainer/Button"


signal finished
signal failed

func _ready() -> void:
	validate_button.connect("pressed",self,"on_validate")
	scroll_offset = Vector2.ZERO
	for k in 8:
		# print(k)
		var graph_node = get_node("A"+str(k+1))
		var texture = load(img_paths[k])
		graph_node.get_node("TextureRect").texture = texture
		# graph_node.get_node("TextureRect").rect_scale = Vector2.ONE * 0.2
		#cercle de centre 300,300 de rayon 150, divisé en 8
		var center = Vector2(400,300)
		var angle = (k+1)*2*PI/8
		var offset = center + 250 * Vector2(sin(angle),cos(angle))
		graph_node.offset = offset
		# graph_node.rect_scale = 0.2 *Vector2.ONE


func _on_GraphEdit_connection_request(from: String, from_slot: int, to: String, to_slot: int) -> void:
	for k in get_connection_list():
		if k["from"] == from:
			disconnect_node(k["from"],k["from_port"],k["to"],k["to_port"])
		if k["to"] == to:
			disconnect_node(k["from"],k["from_port"],k["to"],k["to_port"])

	connect_node(from,from_slot,to,to_slot)


func on_validate():
	var entry = get_node("A4")
	var response = [
		"A4",
		"A6",
		"A2",
		"A3",
		"A8",
		"A1",
		"A5",
		"A7",
	]
	var success = true
	for k in len(response):
		var current = response[k]
		var next = response[(k+1) % (len(response))]
		success = success and is_node_connected(current,0,next,0)
	if success:
		emit_signal('finished')
	else:
		emit_signal("failed")
