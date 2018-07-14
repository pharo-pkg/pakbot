Class {
	#name : #CGOPackageUnitTest,
	#superclass : #CGOModelTest,
	#category : 'CargoPackageManager-Tests-Model'
}

{ #category : #'tests-converting' }
CGOPackageUnitTest >> testAsPackageVersionReference [
	| pkgVersion pkgVersionReference |
	pkgVersion := CGOPackageUnit example.
	pkgVersionReference := pkgVersion asPackageVersionReference.
	self assert: pkgVersionReference asString equals: 'UnitTest@2.1.0'.

]

{ #category : #tests }
CGOPackageUnitTest >> testEquals [
	| pkgA pkgB project |
	
	pkgA := CGOPackageUnit example. "UnitTest@2.1"
	pkgB := CGOPackageUnit example
				instVarNamed: 'package' put: (CGOPackageProvider default packageNamed: #UnitFoo);
				yourself.  "UnitFoo@2.1"
	
	self assert: pkgA equals: CGOPackageUnit example.
	self assert: pkgA ~= pkgB.
	
	project := CGOPackageUnit example project 
		instVarNamed: 'version' put: '2.0' asSemanticVersion;
		yourself.
	pkgA instVarNamed: 'project' put: project.
	self assert: pkgA ~= CGOPackageUnit example.
]

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
