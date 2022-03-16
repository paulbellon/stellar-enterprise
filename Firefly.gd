extends Spatial
class_name Firefly

var boids = []
var move_speed = 1
var perception_radius = 2
var velocity = Vector3()
var acceleration = Vector3()
var steer_force = 0.2
var alignment_force = 0.6
var cohesion_force = 0.1
var seperation_force = 0.2


func _ready():
	randomize()
	
	transform.origin = Vector3(rand_range(0, 3), rand_range(0, 3), rand_range(0, 3))
	velocity = Vector3(rand_range(-1, 1), rand_range(-1, 1), rand_range(-1, 1)).normalized() * move_speed


func _process(delta):
	
	var neighbors = get_neighbors(perception_radius)
	
	acceleration += process_alignments(neighbors) * alignment_force
	acceleration += process_cohesion(neighbors) * cohesion_force
	acceleration += process_seperation(neighbors) * seperation_force
		
	velocity += acceleration * delta
#	velocity = velocity.clamped(move_speed)
#	rotation = velocity.angle()
	
	translate(velocity * delta)
	
	transform.origin.x = wrapf(transform.origin.x, -32, get_viewport().size.x + 32)
	transform.origin.y = wrapf(transform.origin.y, -32, get_viewport().size.y + 32)

func process_cohesion(neighbors):
	var vector = Vector3()
	if neighbors.empty():
		return vector
	for boid in neighbors:
		vector += boid.transform.origin
	vector /= neighbors.size()
	return steer((vector - transform.origin).normalized() * move_speed)
		

func process_alignments(neighbors):
	var vector = Vector3()
	if neighbors.empty():
		return vector
		
	for boid in neighbors:
		vector += boid.velocity
	vector /= neighbors.size()
	return steer(vector.normalized() * move_speed)

func process_seperation(neighbors):
	var vector = Vector3()
	var close_neighbors = []
	for boid in neighbors:
		if transform.origin.distance_to(boid.transform.origin) < perception_radius / 2:
			close_neighbors.push_back(boid)
	if close_neighbors.empty():
		return vector
	
	for boid in close_neighbors:
		var difference = transform.origin - boid.transform.origin
		vector += difference.normalized() / difference.length()
	
	vector /= close_neighbors.size()
	return steer(vector.normalized() * move_speed)
	

func steer(var target):
	var steer = target - velocity
	steer = steer.normalized() * steer_force
	return steer
	

func get_neighbors(view_radius):
	var neighbors = []

	for boid in boids:
		if transform.origin.distance_to(boid.transform.origin) <= view_radius and not boid == self:
			neighbors.push_back(boid)
	return neighbors
			
	
