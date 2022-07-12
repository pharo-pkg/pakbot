Class {
	#name : #PBVcsSerializedPackageUnitV1Test,
	#superclass : #TestCase,
	#category : #'CargoPackageManager-Tests-Model-Serialization'
}

{ #category : #tests }
PBVcsSerializedPackageUnitV1Test >> serializedClass [
	^ PBVcsSerializedPackageUnit
]

{ #category : #tests }
PBVcsSerializedPackageUnitV1Test >> testCanDeserializeDepedencyThatIsASymbol [
	| unit dict dependency |
	dict := Dictionary
		with: #name -> #Bar
		with: #dependencies -> #(#Project::Foo).
		
	unit := (self serializedClass fromDictionary: dict) asOngoingPackage.
	
	dependency := unit dependencies first.
	self assert: dependency targetedPackage equals: #Foo.
	self assert: dependency scope equals: #Project
]

{ #category : #tests }
PBVcsSerializedPackageUnitV1Test >> testCanDeserializeDepedencyThatIsAnAssociation [	
	| unit dict dependency |
	dict := Dictionary 
		with: #name -> 'Foo'
		with: #dependencies -> {#Project::Foo -> #('=1.1')}.

	unit := (self serializedClass fromDictionary: dict) asOngoingPackage.
	
	dependency := unit dependencies first.
	self 
		assert: dependency targetedPackage 
		equals: #Foo.
	self 
		assert: dependency constraints size
		equals: 1.
	self 
		assert: dependency constraints first asString
		equals: '1.1'.
]

{ #category : #tests }
PBVcsSerializedPackageUnitV1Test >> testGetEmptyCollectionWhenNoDependency [
	| unit dict |
	dict := Dictionary 
		with: #name -> 'Foo'
		with: #dependencies -> #().
	
	unit := (self serializedClass fromDictionary: dict) asOngoingPackage.
	
	self assert: unit dependencies isEmpty
]
