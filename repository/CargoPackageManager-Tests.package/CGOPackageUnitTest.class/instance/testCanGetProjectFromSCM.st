tests
testCanGetProjectFromSCM
	| projectRepositoryMock unit |
	unit := self unitTestV1 asPackageVersion.
	projectRepositoryMock := protocol mock: 'projectRepositoryMock'.
	protocol describe
		allow: projectRepositoryMock recv: #projectMetadataStonString;
		=> (STON toStringPretty: ongoingProject asCargoProject asSerializableCargoProject).
	unit sourcePackageVersion 
		instVarNamed: 'repository' put: projectRepositoryMock.
	registry reset.
	
	self
		assert: unit project 
		equals: ongoingProject