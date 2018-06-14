initialization
initializeOn: aPackageName withConstraints: aConstraintList
	super initialize.
	self initializeTargetAndScopeFrom: aPackageName.
	constraints := Array newFrom: aConstraintList