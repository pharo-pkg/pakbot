Class {
	#name : #CGOPackageUnitTest,
	#superclass : #PBModelTest,
	#category : #'CargoPackageManager-Tests-Model'
}

{ #category : #tests }
CGOPackageUnitTest >> testInitializeFromEmptyDictionary [
	self 
		should: [ CGOPackageVersion newFrom: Dictionary new ]
		raise: CGOPackageVersionInitializationError
]

{ #category : #tests }
CGOPackageUnitTest >> testInitializeFromWithNoPackageValue [
	| dictionary |
	dictionary := Dictionary with: #package -> nil.
	self 
		should: [ CGOPackageVersion newFrom: dictionary ]
		raise: CGOPackageVersionInitializationError
]

{ #category : #tests }
CGOPackageUnitTest >> testInitializeFromWithNoProject [
	" Could we create a unit without setting its project? "
	| dictionary |
	dictionary := Dictionary	with: #package -> #A.
	self 
		should: [ CGOPackageVersion newFrom: dictionary ]
		raise: CGOPackageVersionInitializationError
]

{ #category : #tests }
CGOPackageUnitTest >> testInitializeFromWitoutProjectRaiseError [
	| dictionary |
	dictionary := Dictionary
		with: #package -> #A.
	self 
		should: [ CGOPackageVersion newFrom: dictionary ]
		raise: CGOPackageVersionInitializationError 
]

{ #category : #tests }
CGOPackageUnitTest >> testProvisionsFromListOfProvisionStrings [
	| provisions |
	provisions := (CGOPackageUnit provisionsFromListOfProvisionStrings: #('A@2.0' 'B')) asArray.
	self 
		assert: provisions first
		equals: 'A@2.0.0' asPackageVersionReference.
	self 
		assert: provisions second
		equals: 'B@1.0.0' asPackageVersionReference.
]
