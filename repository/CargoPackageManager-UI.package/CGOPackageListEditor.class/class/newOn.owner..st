instance creation
newOn: anOngoingPackageVersion owner: owner
	^ self basicNew
		owner: owner;
		initializeWith: anOngoingPackageVersion;
		yourself