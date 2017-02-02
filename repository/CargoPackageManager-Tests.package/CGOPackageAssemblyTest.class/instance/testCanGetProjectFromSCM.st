tests
testCanGetProjectFromSCM
	| projectRepositoryMock assembly |
	projectRepositoryMock := protocol mock: 'projectRepositoryMock'.
	protocol describe
		allow: projectRepositoryMock recv: #projectMetadataStonString;
		=> (STON toStringPretty: ongoingProject asCargoProject asSerializableCargoProject).
	assembly := self assemblyA1.
	assembly instVarNamed: 'projectRepository' put: projectRepositoryMock.
	registry reset.
	
	self
		assert: assembly project 
		equals: ongoingProject