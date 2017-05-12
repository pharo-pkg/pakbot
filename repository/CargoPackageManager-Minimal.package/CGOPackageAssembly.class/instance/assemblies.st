accessing
assemblies
	^ parts
		collect: [ :each | registry packageNamed: each packageName ifAbsent: [ nil ] ]
		thenSelect: [ :each | each notNil and: [ each isAssembly ] ]