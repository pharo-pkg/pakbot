Class {
	#name : #PBSerializedPackageUnitV1Test,
	#superclass : #PBVcsSerializedPackageUnitV1Test,
	#category : #'CargoPackageManager-Tests-Model-Serialization'
}

{ #category : #tests }
PBSerializedPackageUnitV1Test >> serializedClass [
	^ PBSerializedPackage
]

{ #category : #tests }
PBSerializedPackageUnitV1Test >> testSerializedDepedencyHasAFixedVersion [
	| unit dict dependency |
	self skip.
	dict := Dictionary
		with: #name -> #Bar
		with: #dependencies -> #(#Project::Foo).
		
	unit := (self serializedClass fromDictionary: dict) asOngoingPackage.
	
	dependency := unit dependencies first.
	self assert: dependency constraints size equals: 1.
]
