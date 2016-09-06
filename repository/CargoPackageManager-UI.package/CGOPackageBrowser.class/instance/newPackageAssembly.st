actions
newPackageAssembly
	| name rpackage assemblyClass |
	name := UIManager default 
		request: 'Name of the package assembly to create'
		initialAnswer: ''.
	name ifNil: [ ^ nil ].
	rpackage := SearchFacade rPackageSearch
		acceptNewEntry: true;
		chooseFromOwner: World.
	rpackage ifNil: [ ^ nil ].
	rpackage isString ifTrue: 
		[ rpackage := RPackageOrganizer default registerPackageNamed: rpackage ].
	assemblyClass := AssemblyManifest 
		newNamed: (name select: #isAlphaNumeric), 'Assembly'
		category: rpackage name.
	assemblyClass asOngoingPackageVersion updatePackageName: name.
	^ assemblyClass