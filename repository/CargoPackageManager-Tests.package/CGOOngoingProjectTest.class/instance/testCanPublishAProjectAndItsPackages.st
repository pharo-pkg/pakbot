tests
testCanPublishAProjectAndItsPackages
	| packages |
	ongoingProject assemblies: { CGOOngoingPackageAssembly for: #AllPackages in: ongoingProject name }.
	
	[ ongoingProject publishAll ]
		on: CGODifferentPackageVersionsPublication 
		do: [ :ex | ex resume ].
	
	packages := testPackageRepository packageNames.
	self 
		assert: packages size
		equals: 4.
		
	self 
		assertCollection: packages
		hasSameElements: #(myproject package1 package2 allpackages)