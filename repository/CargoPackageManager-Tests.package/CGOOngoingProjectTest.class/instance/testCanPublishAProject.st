tests
testCanPublishAProject
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
		assertCollection: published unitNames
		hasSameElements: #(#Package1 #Package2)