extends Node
class_name DialogueManager

# This is the node "sending" the dialogue data to the DialogueGUI present in the
# Level derived scene. (EG: Level1.tscn)
# It takes in a dialogue_data resource file.
# GUI node = DialogueGUI in the Level scene.


# ----------------- DECLARE VARIABLES -----------------


export var enable_n_times_before_trigger: int = 0
export var remaining_reenable_charges: int = 0


func send_trigger(_arguments) -> void:
	if enable_n_times_before_trigger > 0:
		print("enable_n_times_before_trigger is: ", enable_n_times_before_trigger, " , return")
		enable_n_times_before_trigger -= 1
		return
#	print("enable_n_times_before_trigger decreased: ", enable_n_times_before_trigger)
	print("Send dialogue, n before triggers passed")
	_send_dialogue(_arguments)
	
	if remaining_reenable_charges <= 0:
		print("remaining_reenable_charges is: ", remaining_reenable_charges, " , queue_free() and return")
		self.queue_free()
		return
	remaining_reenable_charges -= 1
	print("remaining_reenable_charges decreased: ", remaining_reenable_charges)



# Node References
export var node_to_connect_to_node_path: NodePath = ""
onready var node_to_connect_to: Node = get_node(self.node_to_connect_to_node_path) if node_to_connect_to_node_path != "" else null

export var dialogue_gui_node_path: NodePath = ""
onready var dialogue_gui: DialogueGUI = get_node(self.dialogue_gui_node_path)


# ---------------------- RUN CODE ---------------------

export var dialogue_data_resource: Resource = null

func _ready() -> void:
	self._initialize_asserts()
	self._initialize_signals()
	self._custom_on_ready()


# ----------------- DECLARE FUNCTIONS -----------------


func _initialize_signals() -> void:
#	Example implementation to override this method
#	node_to_connect_to.connect("signal_with_dictionary_argument", self, "_send_dialogue")
	return


func _initialize_asserts() -> void:
	# No asset for node_to_connect_to_node_path, can "connect to a script"
	# instead (EG: Events autoload)
	assert(self.dialogue_gui_node_path != "")
	assert(self.dialogue_data_resource != null)
	assert(self.dialogue_data_resource.data != [])


# Override to do something on ready rather than overriding ready and not 
# executing the _ready() function
func _custom_on_ready() -> void:
	return


# The _arguments are not actually used: Game jam code architecture bottleneck.
# It's only an argument which prevents a signal error.
# Just provide 0 as an argument if you want to call this method directly.
func _send_dialogue(_arguments) -> void:
	dialogue_gui.receive_dialogue(dialogue_data_resource)
