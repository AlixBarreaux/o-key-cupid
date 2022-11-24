extends Control
class_name DialogueGUI


# ----------------- DECLARE VARIABLES -----------------


# Node References:
export var speaker_texture_node_path: NodePath = NodePath("")
export var message_rich_text_label_node_path: NodePath = NodePath("")
export var animation_tree_node_path: NodePath = NodePath("")

onready var speaker_texture: TextureRect = get_node(speaker_texture_node_path)
onready var message_rich_text_label: RichTextLabel = get_node(message_rich_text_label_node_path)
onready var animation_tree = get_node(animation_tree_node_path)
onready var animation_tree_anim_node_state_machine_playback = get_node(animation_tree.get_path()).get("parameters/playback")


# Variables
var dialogue: Array = []
var speech_index: int = 0


# ---------------------- RUN CODE ---------------------


func _ready() -> void:
	self._initialize()
	return


func _initialize() -> void:
	if not Settings.is_dialogue_system_enabled:
		self.queue_free()
		return
	
	toggle_enabled(false)
	animation_tree.set_active(true)
	return


var first_input_triggered_once: bool = false

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if (event.get_button_index() == 1) or (event.get_button_index() == 2):
			if not event.pressed:
				if not first_input_triggered_once:
					first_input_triggered_once = true
					return
				
				play_next_speech()
				self.accept_event()
	return


func _unhandled_input(event: InputEvent) -> void:
	if (event is InputEventKey) or (event is InputEventJoypadButton):
		if not event.pressed:
			if not first_input_triggered_once:
				first_input_triggered_once = true
				return
			
			play_next_speech()
			get_tree().set_input_as_handled()
	return


# ----------------- DECLARE FUNCTIONS -----------------


func play_next_speech() -> void:
	message_rich_text_label.bbcode_text = dialogue[speech_index].message
	speaker_texture.texture = load(dialogue[speech_index].texture_file_path)
	
	if speech_index == ( dialogue.size() -1 ):
		self.stop()
		return
	
	speech_index += 1
	return


func stop() -> void:
	print(self.name, ": The dialog has stopped, all speech lines have been played!")
	toggle_enabled(false)
	return


func receive_dialog(data: Array) -> void:
	dialogue = data
	toggle_enabled(true)
	play_next_speech()
	
	return


func toggle_enabled(enabled: bool) -> void:
	if enabled:
		self.show()
		self.set_process_unhandled_input(true)
		animation_tree_anim_node_state_machine_playback.start("Start")
	else:
		self.hide()
		self.set_process_unhandled_input(false)
		animation_tree_anim_node_state_machine_playback.travel("End")
	
	return