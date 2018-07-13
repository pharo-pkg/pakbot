solving
resolveInSolver: aCGOSolver 
	
	"A metacello configuration project is already solved. It has only a single version and no other constraints, and a single url"
	^ (PBMetacelloProject fromProjectDependency: self)
			registry: project registry