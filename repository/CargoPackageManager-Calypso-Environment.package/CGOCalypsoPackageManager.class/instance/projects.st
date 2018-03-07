accessing
projects
	^ cargoRegistry registeredProjects 
		collect: 	[ :each | ClyManagedProject for: each named: each packageName managedBy: self]