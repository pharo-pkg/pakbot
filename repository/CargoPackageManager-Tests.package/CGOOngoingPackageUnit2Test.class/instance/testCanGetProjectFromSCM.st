tests
testCanGetProjectFromSCM
	| projectRepositoryMock unit |
	unit := self unitTestV1.
	registry reset.

	projectRepositoryMock := protocol mock: 'projectRepositoryMock'.
	protocol describe
		allow: projectRepositoryMock recv: #projectMetadataStonString;
		=> (STON toStringPretty: ongoingProject asCargoProject asSerializableCargoProject).
	unit sourcePackageVersion 
		instVarNamed: 'repository' put: projectRepositoryMock.
	
	self
		assert: unit project 
		equals: ongoingProject