Class {
	#name : #CGOVcsSerializedPackageUnitV1Test,
	#superclass : #TestCase,
	#category : #'CargoPackageManager-Tests-Model-Serialization'
}

{ #category : #tests }
CGOVcsSerializedPackageUnitV1Test >> testCanDeserializeDepedencyThatIsASymbol [	
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
CGOVcsSerializedPackageUnitV1Test >> testCanDeserializeDepedencyThatIsAnAssociation [	
	| serializedUnit stonString unit |
	serializedUnit := CGOVcsSerializedPackageUnit new 
		instVarNamed: 'dependencies' put: {#Project::Foo -> #()};
		yourself.
	stonString := STON toString: serializedUnit.
	
	unit := STON fromString: stonString.
	
	self assert: (unit dependencies allSatisfy: [ :each | each class = Association ])
]

{ #category : #tests }
CGOVcsSerializedPackageUnitV1Test >> testGetEmptyCollectionWhenNoDependency [
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
