accessing
packagesOf: aCGOProject
	^ aCGOProject packageUnits
		collect: [ :each | self packageOf: each ]