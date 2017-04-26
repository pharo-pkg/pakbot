accessing
projects
	^ cargoRegistry installedProjects 
		collect: 	[ :each | ClyManagedProject for: each named: each packageName managedBy: self]