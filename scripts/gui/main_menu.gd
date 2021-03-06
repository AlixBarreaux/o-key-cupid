class_name MainMenu
extends Control


# ----------------- DECLARE VARIABLES -----------------

# Node Paths
export (NodePath) var first_button_to_focus_node_path = null

onready var first_button_to_focus: Button = get_node(first_button_to_focus_node_path)


# ----------------- RUN CODE -----------------


func _ready() -> void:
	self._initialize_asserts()
	self._initialize()
	return


# ----------------- DECLARE FUNCTIONS -----------------


func _initialize_asserts() -> void:
	assert(self.first_button_to_focus_node_path != null)
	

func _initialize() -> void:
	self.first_button_to_focus.grab_focus()
	
	if not MenusMusic.has_been_played_at_least_once:
		MenusMusic.play()
		MenusMusic.has_been_played_at_least_once = true
	return


func _on_PlayButton_pressed() -> void:
	MenusMusic.stop()
	return
