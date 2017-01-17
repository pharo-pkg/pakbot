initialization
initialize
	super initialize.
	repositories := { self class defaultPackageRepository }.
	packages := OrderedCollection new