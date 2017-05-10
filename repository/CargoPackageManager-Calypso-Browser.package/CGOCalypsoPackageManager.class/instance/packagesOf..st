accessing
packagesOf: aCGOProject
	^ aCGOProject packageUnits
		collect: [ :each | self packageNamed: each packageName ]