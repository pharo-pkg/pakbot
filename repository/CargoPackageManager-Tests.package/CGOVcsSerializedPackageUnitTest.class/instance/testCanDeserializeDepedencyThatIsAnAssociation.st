tests
testCanDeserializeDepedencyThatIsAnAssociation	
	| serializedUnit stonString unit |
	serializedUnit := CGOVcsSerializedPackageUnit new 
		instVarNamed: 'dependencies' put: {#Project::Foo -> #()};
		yourself.
	stonString := STON toString: serializedUnit.
	
	unit := STON fromString: stonString.
	
	self assert: (unit dependencies allSatisfy: [ :each | each class = Association ])