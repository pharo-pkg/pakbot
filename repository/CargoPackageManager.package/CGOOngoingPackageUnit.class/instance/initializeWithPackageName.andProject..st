initialization
initializeWithPackageName: aPackageName andProject: aCargoProjectName
	super initializeWithPackageName: aPackageName andProject: aCargoProjectName.
	dependencies := OrderedCollection new.
	provisions := OrderedCollection new: 0.
	platformRequirements := OrderedCollection new: 0.	
	aCargoProjectName ifNotNil: 
		[ self project repository ifNotNil: 
			[ :projectRepo |
			src := CGOSourcePackageVersion 
				repository: 	projectRepo
				packageName: self packageName. ] ].