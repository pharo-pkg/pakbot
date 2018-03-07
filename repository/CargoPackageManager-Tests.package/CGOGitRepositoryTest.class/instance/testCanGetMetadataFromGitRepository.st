tests
testCanGetMetadataFromGitRepository
	| project |
	"CGOPackageVersion"
	project := CGOOngoingProject fromStonString: self pharoCounterMaster projectMetadataStonString.
	
	self 
		assert: project packageName
		equals: #Counter.
	self 
		assert: project packageUnits anyOne class 
		equals: CGOOngoingPackageUnit.
	
	self 
		assert: (project packageUnits collect: #packageName) sorted
		equals: #('Counter-Core' 'Counter-Tests').
		
	self 
		assert: (project packageUnits detect: [ :each | each packageName = #'Counter-Core']) dependencies
		equals: #().
	self 
		assert: (project packageUnits detect: [ :each | each packageName = #'Counter-Tests']) dependencies size
		equals: 1.
	self 
		assert: project assemblies isEmpty.
