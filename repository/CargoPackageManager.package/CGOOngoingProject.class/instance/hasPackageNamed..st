testing
hasPackageNamed: aString 
	
	^ units anySatisfy: [ :any | any packageName = aString ]