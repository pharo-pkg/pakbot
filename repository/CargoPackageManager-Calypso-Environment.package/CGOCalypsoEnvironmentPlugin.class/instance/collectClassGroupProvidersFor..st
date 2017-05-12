accessing
collectClassGroupProvidersFor: aPackage

	^ (aPackage isKindOf: ClyManagedPackage)
		ifTrue: [ {CGOClyDependencyGroupProvider package: aPackage} ]
		ifFalse: [ #() ]