instance creation
newOn: anOngoingVirtualPackageVersion owner: owner
	^ self basicNew
		initializeWith: anOngoingVirtualPackageVersion;
		yourself