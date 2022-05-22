extends Spatial

export (Array, NodePath) var deck_machines
export (Dictionary) var computer_reactions

var main_sector_data : SectorList = load("res://navigation_table/sectors/main_sector_list.tres")
var has_power: bool = true

onready var computer_voice = $ComputerVoice
onready var timer = $Timer

func _ready():
# warning-ignore:return_value_discarded
	main_sector_data.connect("docking", self, "initiate_docking")
# warning-ignore:return_value_discarded
	main_sector_data.connect("set_destination", self, "auto_pilot")
# warning-ignore:return_value_discarded
	owner.connect("power_off", self, "batteries_low")
# warning-ignore:return_value_discarded
	owner.connect("event_finished", self, "no_power")
	
	deck_machine()

func auto_pilot():
	computer_voice.stream = computer_reactions["Autopilot"]
	computer_voice.play()
	
func initiate_docking():
	computer_voice.stream = computer_reactions["Docking"]
	computer_voice.play()
	
func batteries_low():
	computer_voice.stream = computer_reactions["Batteries"]
	computer_voice.play()

func deck_machine():
	while has_power == true:
		timer.start(rand_range(1.0, 5.0))
		yield(timer, "timeout")
		var machine = get_node(deck_machines[round(rand_range(0, deck_machines.size() - 1))])
		machine.play()
		yield(machine, "finished")
	
func no_power():
	has_power = false
	$DeckAmbient.stop()
	$HallwayAmbient1.stop()
	$HallwayAmbient2.play()
	
