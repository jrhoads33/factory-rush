class_name MachineLookup
extends Node

static var machine_dict : Dictionary[String, MachineDefinition] = {
	"conveyer": preload("res://data/machines/converyer.tres"),
	"hopper": preload("res://data/machines/collector_hopper.tres")
}
