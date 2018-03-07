accessing
dependencies
	^ dependencies collect: [ :each |
		each isSymbol 	
			ifTrue: [ Association key: each value: #() ]
			ifFalse: [ each ] ]