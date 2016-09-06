initialization
initializeWith: anOngoingPackageUnit
	super initialize.
	ongoingPackageVersion := anOngoingPackageUnit.
	self refreshWidgetValues