converting
asSerializableRepository
	^ self copy
		instVarNamed: 'repositoryUrl' put: repositoryUrl asString;
		yourself 