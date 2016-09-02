instance creation
newNamed: aName
	^ self new
		initializeWithName: aName asSymbol;
		yourself