"
Current version of the package assembly metadata. As a PackageVersion is not editable, it is the only way  to update it.
"
Class {
	#name : #CGOOngoingPackageAssembly,
	#superclass : #CGOOngoingPackage,
	#instVars : [
		'parts'
	],
	#category : 'CargoPackageManager-Model'
}

{ #category : #example }
CGOOngoingPackageAssembly class >> example [
	^ (self named: #TestAssembly)
		description: 'A simple ongoing package assembly.';
		parts: #('Unit1' 'Unit2');
		project: (CGOOngoingProject named: #MyProject);
		yourself
]

{ #category : #'instance creation' }
CGOOngoingPackageAssembly class >> named: aString inProject: aProject [

	^ self basicNew
		initializeWithPackageName: aString andProject: aProject;
		yourself 
		
]

{ #category : #updating }
CGOOngoingPackageAssembly >> addPart: aPackageNameOraPackageVersionReference [ 
	| pkgVersionRef constraints |
	pkgVersionRef := aPackageNameOraPackageVersionReference asPackageVersionReference.
	constraints := pkgVersionRef versionNumber 
		ifNil: [ #() ]
		ifNotNil: [ Array with: '=' , pkgVersionRef versionString ].
	parts add: (CGOPackageDependency newFrom: pkgVersionRef packageName  -> constraints)
]

{ #category : #accessing }
CGOOngoingPackageAssembly >> allPackageUnits [
	" returns the list of package units part of the assembly recursively, flattening package assemblies"
	
	| units |
	units := (self assemblies flatCollect: #allPackageUnits as: Set).
	units addAll: self packageUnits.
	^ units
]

{ #category : #converting }
CGOOngoingPackageAssembly >> asPackageVersionOf: aCGOProject [
	^ CGOPackageAssembly fromOngoing: self project: aCGOProject 
]

{ #category : #converting }
CGOOngoingPackageAssembly >> asVcsSerializedPackageAssembly [
	"VCS version of the unit metadata (i.e. minimum metadata)"
	^ CGOVcsSerializedPackageAssembly from: self
]

{ #category : #accessing }
CGOOngoingPackageAssembly >> assemblies [
	^ self partsFromRegistry: [ :each | each notNil and: [ each isAssembly ] ]
]

{ #category : #accessing }
CGOOngoingPackageAssembly >> dependencies [
	"for polymorphism with Package Unit"
	^ self parts
]

{ #category : #initialization }
CGOOngoingPackageAssembly >> initializeFromPackageVersion: aCGOPackageVersion [
	super initialize.
	package := aCGOPackageVersion package.
	description := aCGOPackageVersion copy.
	parts := aCGOPackageVersion dependencies collect: #copy as: OrderedCollection.

]

{ #category : #initialization }
CGOOngoingPackageAssembly >> initializeFromVcsSerializedPackage: aCGOVcsSerializedPackageAssembly [ 
	super initializeWithPackageName: aCGOVcsSerializedPackageAssembly name andProject: nil. "will be set later by CGOVcsSerializedProject>>#flushIn:"
	description := aCGOVcsSerializedPackageAssembly description.
	parts := self deserializedDependencies: aCGOVcsSerializedPackageAssembly parts.
]

{ #category : #initialization }
CGOOngoingPackageAssembly >> initializeWithPackageName: aPackageName andProject: aCargoProjectName [
	super initializeWithPackageName: aPackageName andProject: aCargoProjectName.
	parts := OrderedCollection new.
]

{ #category : #testing }
CGOOngoingPackageAssembly >> isAssembly [
	^ true
]

{ #category : #testing }
CGOOngoingPackageAssembly >> isEmpty [
	^ self parts isEmpty
]

{ #category : #'querying - installed' }
CGOOngoingPackageAssembly >> isInstalled [
	
	^ (self parts collect: #asPackageDependency) allSatisfy: #isInstalled
]

{ #category : #accessing }
CGOOngoingPackageAssembly >> packageUnitNames [
	^ self packageUnits collect: #packageName
]

{ #category : #accessing }
CGOOngoingPackageAssembly >> packageUnits [
	^ self partsFromRegistry: [ :each | each notNil and: [ each isUnit ] ]
]

{ #category : #accessing }
CGOOngoingPackageAssembly >> packages [
	^ self packageUnits , self assemblies
]

{ #category : #accessing }
CGOOngoingPackageAssembly >> parts [
	^ parts
]

{ #category : #updating }
CGOOngoingPackageAssembly >> parts: aListOfCGOPackageDependency [
	parts := aListOfCGOPackageDependency
]

{ #category : #private }
CGOOngoingPackageAssembly >> partsFromRegistry: filterBlock [
	^ parts
		collect: [ :each | 
			self project registry 
				packageNamed: each packageName 
				ifAbsent: [ CGOPackageNotFoundError signal: each packageName ] ]
		thenSelect: filterBlock
]

{ #category : #updating }
CGOOngoingPackageAssembly >> removePart: aCGOPackageDependency [ 
	parts remove: aCGOPackageDependency
]
