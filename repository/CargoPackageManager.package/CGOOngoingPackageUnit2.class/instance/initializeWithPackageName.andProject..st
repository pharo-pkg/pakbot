initialization
initializeWithPackageName: aPackageName andProject: aCargoProjectName
	super initializeWithPackageName: aPackageName andProject: aCargoProjectName.
	dependencies := OrderedCollection new.
	provisions := OrderedCollection new: 0.
	platformRequirements := OrderedCollection new: 0.	
	aCargoProjectName ifNotNil: 
		[ src := CGOSourcePackageVersion 
		repository: 	self project repository
		packageName: self packageName ]