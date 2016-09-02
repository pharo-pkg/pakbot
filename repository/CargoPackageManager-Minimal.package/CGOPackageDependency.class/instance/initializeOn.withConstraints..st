initialization
initializeOn: aPackageName withConstraints: aConstraintList
	super initialize.
	targetedPackage := aPackageName asSymbol.
	constraints := Array newFrom: aConstraintList