accessing
assemblies
	^ self partsFromRegistry: [ :each | each notNil and: [ each isAssembly ] ]