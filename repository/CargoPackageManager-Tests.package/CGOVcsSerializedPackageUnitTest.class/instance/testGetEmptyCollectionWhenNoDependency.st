tests
testGetEmptyCollectionWhenNoDependency
	| serializedUnit stonString unit |
	serializedUnit := CGOVcsSerializedPackageUnit new 
		instVarNamed: 'dependencies' put: #();
		yourself.
	stonString := STON toString: serializedUnit.
	
	unit := STON fromString: stonString.
	
	self 
		assert: unit dependencies
		equals: #()