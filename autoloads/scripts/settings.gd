extends Node
#tool


# ----------------- DECLARE VARIABLES -----------------

var is_dialogue_system_enabled: bool = true

# ----------------- RUN CODE -----------------


func _ready() -> void:
	# Code to run in Dev mode
#	print(Engine.is_editor_hint())
#	if Engine.is_editor_hint():
#
#		OS.set_window_fullscreen(false)
#		return
		
		
	OS.set_window_fullscreen(false)
	TranslationServer.set_locale(OS.get_locale())
	return


# ----------------- DECLARE FUNCTIONS -----------------

