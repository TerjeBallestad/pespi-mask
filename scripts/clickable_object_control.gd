extends Node2D


var hoveredElement = null
var selectedElement = null
var Selections:= []

func unsetHoveredNode(node):
	if self.hoveredElement == node:
		self.hoveredElement = null
	Selections.erase(node)
	if Selections.is_empty():
		return
	self.hoveredElement = Selections[-1]

# Returns boolean if it is the new top hovered object
func setHoveredNode(node1):
	Selections.append(node1)
	if self.hoveredElement == null or self.hoveredElement == node1:
		self.hoveredElement = node1
		return true
 
	var nodes = get_tree().get_nodes_in_group('clickableObject')
	var hoveredPosition = 0
	var i = 0
	for node in nodes:
		if node == self.hoveredElement:
			hoveredPosition = i
			break
		i += 1

	var node1Position = 0
	i = 0
	for node in nodes:
		if node == node1:
			node1Position = i
			break
		i += 1

	if node1Position >= hoveredPosition:
		self.hoveredElement = node1
		return true
	else:
		return false

func _input(event):
	if event is InputEventMouseButton && event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			print("click registerd")
			if self.hoveredElement == null:
				# No object is being clicked, so deselect selected node
				self.selectedElement = null
			else:
				# Call left click for only the top object that is being clicked
				self.hoveredElement.leftMouseClick()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
