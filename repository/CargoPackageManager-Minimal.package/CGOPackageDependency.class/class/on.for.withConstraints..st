instance creation
on: targetedPackageName for: aPackageName withConstraints: contraints
	self flag: 'TODO: set the dependent with aPackage'.
	^ self new
		initializeOn: targetedPackageName withConstraints: contraints;
		yourself.