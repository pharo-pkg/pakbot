initialization
initialize
	super initialize.
	repositories := { DefaultPackageRepository }.
	sourceRepositories := OrderedCollection new.
	packages := OrderedCollection new