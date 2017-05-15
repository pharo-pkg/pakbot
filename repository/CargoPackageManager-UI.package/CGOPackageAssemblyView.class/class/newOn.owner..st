instance creation
newOn: anOngoingPackageAssembly owner: owner
	^ self basicNew
		initializeWith: anOngoingPackageAssembly;
		yourself