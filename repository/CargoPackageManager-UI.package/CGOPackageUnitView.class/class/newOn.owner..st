instance creation
newOn: anOngoingPackageUnit owner: owner
	^ self basicNew
		initializeWith: anOngoingPackageUnit;
		yourself