checking requirements
fitsSmalltalkVersionRequirementsOf: anEnvironment
	^ self smalltalkVersion
		ifNil: [ true ]
		ifNotNil: [ self smalltalkVersion = anEnvironment smalltalkVersion ]