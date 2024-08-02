extends Node3D

@export var spikeRows = 2
@export var spikeRings = 1
@export var spikeSize = .7

var piloting = true
# Distance between spikes
var spikeOffset = 2*PI/spikeRows
# Distance between rings
var ringOffset: float = 2.0/(spikeRings + 1)
# Offset to make rings alternate instead of just being parallel
var alternatingOffset


func _ready():
	for i in spikeRings:
		# Create new ring
#		var newRing = Node3D.new()
		var newRing = load("res://Objects/ring.tscn").instantiate()
		for j in spikeRows:
			# Add spikes to the ring
			var newSpike = load("res://Objects/spike.tscn").instantiate()
			newRing.add_child(newSpike)
		$Grinder.add_child(newRing)
	# Reposition the created objects
	updateSpikes()
	updateRings()
	updateSpikeSize()

func _process(_delta):
	if piloting:
		$Grinder.rotate_x(0.05)

func add_spike():
	# Spike limit
	if spikeRows < 12:
		spikeRows += 1
		spikeOffset = 2*PI/spikeRows
		for ring in $Grinder.get_children():
			if ring.is_in_group("ring"):
				# Add a new spike to every ring
				var newSpike = load("res://Objects/spike.tscn").instantiate()
				ring.add_child(newSpike)
		updateSpikes()
		updateRings()
		updateSpikeSize()

func add_ring():
	# Ring limit
	if spikeRings < 11:
		spikeRings += 1
		ringOffset = 2.0/(spikeRings + 1)
		# Add new ring and fill it with spikes
		var newRing = load("res://Objects/ring.tscn").instantiate()
		for i in spikeRows:
			var newSpike = load("res://Objects/spike.tscn").instantiate()
			newSpike.rotation.x = i * spikeOffset
			newRing.add_child(newSpike)
		$Grinder.add_child(newRing)
		updateSpikes()
		updateRings()
		updateSpikeSize()

func add_size():
	if spikeSize < 1.7:
		spikeSize += 0.1
		updateSpikeSize()

func updateSpikes():
	var spikeCounter = 0
	
	# Reposition spikes
	for ring in $Grinder.get_children():
		if ring.is_in_group("ring"):
			for spike in ring.get_children():
				if spike.is_in_group("spike"):
					spike.rotation.x = spikeCounter * spikeOffset
					spikeCounter += 1
	
	#print(spikeCounter)

func updateRings():
	var ringCounter = 0
	
	# Reposition rings
	for ring in $Grinder.get_children():
		if ring.is_in_group("ring"):
			alternatingOffset = (spikeOffset/2) * ringCounter
			ring.position.x = -1 + ringOffset * (ringCounter + 1)
			ring.rotation.x = alternatingOffset
			ringCounter += 1
	
	#print(ringCounter)

func updateSpikeSize():
	for ring in $Grinder.get_children():
		if ring.is_in_group("ring"):
			for spike in ring.get_children():
				if spike.is_in_group("spike"):
					spike.get_node("Mesh").scale = Vector3(spikeSize,spikeSize,spikeSize)
	
