class_name InteractionReceiver
extends Area2D


# ----------------- DECLARE VARIABLES -----------------

export var can_receive_interaction_from_raycast: bool = true

signal interaction_received

# ----------------- RUN CODE -----------------



# ----------------- DECLARE FUNCTIONS -----------------

func _receive_interaction() -> void:
	self.emit_signal("interaction_received")
	return


func _on_InteractionReceiverArea2D_body_entered(_body: PhysicsBody2D) -> void:
	self._receive_interaction()
