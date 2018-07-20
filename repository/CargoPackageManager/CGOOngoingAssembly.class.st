"
Current version of the package assembly metadata. As a PackageVersion is not editable, it is the only way  to update it.
"
Class {
	#name : #CGOOngoingAssembly,
	#superclass : #CGOProjectElement,
	#instVars : [
		'packages'
	],
	#category : #'CargoPackageManager-Model'
}

{ #category : #example }
CGOOngoingAssembly class >> example [
	^ (self named: #TestAssembly)
		description: 'A simple ongoing package assembly.';
		parts: #('Unit1' 'Unit2');
		project: (CGOOngoingProject named: #MyProject);
		yourself
]

{ #category : #'instance creation' }
CGOOngoingAssembly class >> named: aString inProject: aProject [

	^ self basicNew
		initializeWithPackageName: aString andProject: aProject;
		yourself 
		
]

{ #category : #updating }
CGOOngoingAssembly >> addPart: aPackageNameOraPackageVersionReference [ 
	| pkgVersionRef constraints |
	pkgVersionRef := aPackageNameOraPackageVersionReference asPackageVersionReference.
	constraints := pkgVersionRef versionNumber 
		ifNil: [ #() ]
		ifNotNil: [ Array with: '=' , pkgVersionRef versionString ].
	packages add: (CGOPackageDependency newFrom: pkgVersionRef packageName  -> constraints)
]

{ #category : #accessing }
CGOOngoingAssembly >> allPackageUnits [
	" returns the list of package units part of the assembly recursively, flattening package assemblies"
	
	| units |
	units := (self assemblies flatCollect: #allPackageUnits as: Set).
	units addAll: self packageUnits.
	^ units
]

{ #category : #converting }
CGOOngoingAssembly >> asPackageVersionOf: aCGOProject [
	^ CGOPackageAssembly fromOngoing: self project: aCGOProject 
]

{ #category : #converting }
CGOOngoingAssembly >> asVcsSerializedPackageAssembly [
	"VCS version of the unit metadata (i.e. minimum metadata)"
	^ CGOVcsSerializedPackageAssembly from: self
]

{ #category : #accessing }
CGOOngoingAssembly >> assemblies [
	^ self partsFromRegistry: [ :each | each notNil and: [ each isAssembly ] ]
]

{ #category : #accessing }
CGOOngoingAssembly >> dependencies [
	"for polymorphism with Package Unit"
	^ self parts
]

{ #category : #initialization }
CGOOngoingAssembly >> initializeFromPackageVersion: aCGOPackageVersion [
	self initialize.
	packages := aCGOPackageVersion dependencies collect: #copy as: OrderedCollection.

]

{ #category : #initialization }
CGOOngoingAssembly >> initializeFromVcsSerializedPackage: aCGOVcsSerializedPackageAssembly [ 
	"The project will be set later by CGOVcsSerializedProject>>#flushIn:"
	super initializeWithPackageName: aCGOVcsSerializedPackageAssembly name andProject: nil.
	packages := self deserializedDependencies: aCGOVcsSerializedPackageAssembly parts.
]

{ #category : #initialization }
CGOOngoingAssembly >> initializeWithPackageName: aPackageName andProject: aCargoProject [
	
	name := aPackageName.
	project := aCargoProject.
	packages := OrderedCollection new.
]

{ #category : #testing }
CGOOngoingAssembly >> isAssembly [
	^ true
]

{ #category : #testing }
CGOOngoingAssembly >> isEmpty [
	^ self parts isEmpty
]

{ #category : #'querying - installed' }
CGOOngoingAssembly >> isInstalled [
	
	^ (self parts collect: #asPackageDependency) allSatisfy: #isInstalled
]

{ #category : #accessing }
CGOOngoingAssembly >> packageNames [
	^ self packageUnits collect: #packageName
]

{ #category : #accessing }
CGOOngoingAssembly >> packageUnits [
	^ self partsFromRegistry: [ :each | each notNil and: [ each isUnit ] ]
]

{ #category : #accessing }
CGOOngoingAssembly >> packages [
	^ self packageUnits , self assemblies
]

{ #category : #accessing }
CGOOngoingAssembly >> parts [
	^ packages
]

{ #category : #updating }
CGOOngoingAssembly >> parts: aListOfCGOPackageDependency [
	packages := aListOfCGOPackageDependency
]

{ #category : #private }
CGOOngoingAssembly >> partsFromRegistry: filterBlock [
	^ packages
		collect: [ :each | 
			self project registry 
				packageNamed: each packageName 
				ifAbsent: [ CGOPackageNotFoundError signal: each packageName ] ]
		thenSelect: filterBlock
]

{ #category : #updating }
CGOOngoingAssembly >> removePart: aCGOPackageDependency [ 
	packages remove: aCGOPackageDependency
]
