class_name PauseMenu
extends Control


# ----------------- DECLARE VARIABLES -----------------


# Node Paths
export (NodePath) var first_button_to_focus_node_path = null

onready var first_button_to_focus: TextureButton = get_node(first_button_to_focus_node_path)


# ----------------- RUN CODE -----------------


func _ready() -> void:
	self._initialize_asserts()
	self._initialize()
	return


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_released("pause_menu"):
		self.visible = !visible
		get_tree().set_input_as_handled()
	return


# ----------------- DECLARE FUNCTIONS -----------------


func _initialize_asserts() -> void:
	assert(self.first_button_to_focus_node_path != null)
	return


func _initialize() -> void:
	self.hide()
	self.first_button_to_focus.grab_focus()
	return


func set_paused(paused: bool) -> void:
	get_tree().paused = paused
	self.visible = paused
	
	if paused:
		self.first_button_to_focus.grab_focus()
	else:
		self.first_button_to_focus.release_focus()
	return


func toggle_paused() -> void:
	if not get_tree().paused:
		set_paused(true)
	else:
		set_paused(false)
	return


func _on_ResumeTextureButton_pressed() -> void:
	self.hide()
	return


func _on_PauseMenu_visibility_changed() -> void:
	if visible:
		set_paused(true)
	else:
		set_paused(false)


func _on_OptionsTextureButton_pressed() -> void:
	$ScreenMenuOptions.show()
	return


func _on_ScreenMenuOptions_visibility_changed() -> void:
	$IconsContainer/CenterContainer2/OptionsTextureButton.grab_focus()
	return
