tests
testCanGetProjectFromSCM
	| projectSourceRepositoryMock project |
	projectSourceRepositoryMock := protocol mock: 'projectSourceRepositoryMock'.
	protocol describe
		allow: projectSourceRepositoryMock recv: #projectMetadataStonString;
		=> (STON toStringPretty: CGOOngoingProject example asVcsSerializedCargoProject).
	project := CGOOngoingProject fromRepository: projectSourceRepositoryMock.
	registry reset.
	
	self
		assert: project 
		equals: CGOOngoingProject example