adding
registerProjectFromSourceRepository: aCGOSourceRepository
	| project |
	
	project := CGOProject fromStonString: aCGOSourceRepository projectMetadataStonString.
	packageVersions add: project.
	project packageUnitNames
		collect: [ :unitName |
			CGOPackageVersion fromStonString: (aCGOSourceRepository packageMetadataStonStringFor: unitName) ]
		thenDo: [ :unit | packageVersions add: unit ].
	^ project
