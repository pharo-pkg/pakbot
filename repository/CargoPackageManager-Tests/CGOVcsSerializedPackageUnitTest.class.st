Class {
	#name : #CGOVcsSerializedPackageUnitTest,
	#superclass : #TestCase,
	#category : 'CargoPackageManager-Tests-Model-Serialization'
}

{ #category : #tests }
CGOVcsSerializedPackageUnitTest >> testCanDeserializeDepedencyThatIsASymbol [	
	| serializedUnit stonString unit |
	serializedUnit := CGOVcsSerializedPackageUnit new 
		instVarNamed: 'name' put: #Bar;
		instVarNamed: 'dependencies' put: #(#Project::Foo);
		yourself.
	stonString := STON toString: serializedUnit.

	unit := STON fromString: stonString.
	
	self assert: (unit dependencies allSatisfy: [ :each | each class = Association ])
]

{ #category : #tests }
CGOVcsSerializedPackageUnitTest >> testCanDeserializeDepedencyThatIsAnAssociation [	
	| serializedUnit stonString unit |
	serializedUnit := CGOVcsSerializedPackageUnit new 
		instVarNamed: 'dependencies' put: {#Project::Foo -> #()};
		yourself.
	stonString := STON toString: serializedUnit.
	
	unit := STON fromString: stonString.
	
	self assert: (unit dependencies allSatisfy: [ :each | each class = Association ])
]

{ #category : #tests }
CGOVcsSerializedPackageUnitTest >> testGetEmptyCollectionWhenNoDependency [
	| serializedUnit stonString unit |
	serializedUnit := CGOVcsSerializedPackageUnit new 
		instVarNamed: 'dependencies' put: #();
		yourself.
	stonString := STON toString: serializedUnit.
	
	unit := STON fromString: stonString.
	
	self 
		assert: unit dependencies
		equals: #()
]
