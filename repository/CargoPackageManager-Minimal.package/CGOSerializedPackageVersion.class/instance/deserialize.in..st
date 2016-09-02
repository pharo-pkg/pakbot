deserialization
deserialize: instVarName in: aPackageVersion
	| deps |
	deps := self instVarNamed: instVarName.
	aPackageVersion 
		instVarNamed: instVarName
		put: (deps 
			ifNil: [ #() ]
			ifNotNil: [ deps collect:
				[ :association | CGOPackageDependency newFrom: association ] ])