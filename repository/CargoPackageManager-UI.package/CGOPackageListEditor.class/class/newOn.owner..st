instance creation
newOn: anOngoingPackageVersion owner: owner
	^ self basicNew
		initializeWith: anOngoingPackageVersion;
		yourself