tests
testRaisesWarningWhenPublishingDifferentVersions
	ongoingProject assemblies: { CGOOngoingPackageAssembly for: #AllPackages in: ongoingProject name }.
	
	self 
		should: [ ongoingProject publishAll ]
		raise: CGODifferentPackageVersionsPublication
		whoseDescriptionIncludes: 'has a different version'
		description: 'ensure we get a warning when trying to publish a project having packges in a different version than the project'.
		
	self 
		assert: testPackageRepository packages isEmpty
		description: 'ensure no package has been published before one handle the warning'