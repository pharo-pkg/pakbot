Extension { #name : #CGOOngoingProjectTest }

{ #category : #'*CargoPackageManager-FailingTests' }
CGOOngoingProjectTest >> testCanGetProjectFromSCM [
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
]

{ #category : #'*CargoPackageManager-FailingTests' }
CGOOngoingProjectTest >> testCanPublishAProject [
	| published |
	ongoingProject publish.
	
	self 
		assert: testPackageRepository packageNames size
		equals: 1.
	published := testPackageRepository 
		fetch: ongoingProject packageName
		version: ongoingProject version.
	self 
		assert: published class
		equals: CGOProject.
	self 
		assertCollection: published packageUnitNames
		hasSameElements: #(#Package1 #Package2)
]

{ #category : #'*CargoPackageManager-FailingTests' }
CGOOngoingProjectTest >> testCanPublishAProjectAndItsPackages [
	| packages |
	ongoingProject assemblies: { CGOOngoingPackageAssembly for: #AllPackages in: ongoingProject name }.
	
	ongoingProject publishAll.
	
	packages := testPackageRepository packageNames.
	self 
		assert: packages size
		equals: 4.
		
	self 
		assertCollection: packages
		hasSameElements: #(myproject package1 package2 allpackages)
]
