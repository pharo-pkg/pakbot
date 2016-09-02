initialization
initialize
	super initialize.
	constraintsMap := Dictionary new.
	resolution := CGODependencyResolution new.
	repositories := OrderedCollection new