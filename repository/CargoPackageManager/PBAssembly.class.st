"
Current version of the package assembly metadata. As a PackageVersion is not editable, it is the only way  to update it.
"
Class {
	#name : #PBAssembly,
	#superclass : #PBProjectElement,
	#instVars : [
		'packages'
	],
	#category : #'CargoPackageManager-Model'
}

{ #category : #example }
PBAssembly class >> example [
	^ (self named: #TestAssembly)
		description: 'A simple ongoing package assembly.';
		parts: #('Unit1' 'Unit2');
		project: (PBProject named: #MyProject);
		yourself
]

{ #category : #'instance creation' }
PBAssembly class >> named: aString inProject: aProject [

	^ self basicNew
		initializeWithPackageName: aString andProject: aProject;
		yourself 
		
]

{ #category : #comparing }
PBAssembly >> = anAssembly [

	self species = anAssembly species ifFalse: [ ^ false ].
	^ self name = anAssembly name
]

{ #category : #adding }
PBAssembly >> addPackage: aPackage [
	
	self doAddPackage: aPackage.
	self project announceChanged.
	^ aPackage
]

{ #category : #adding }
PBAssembly >> addPackages: aCollection [
	
	aCollection do: [ :each | self doAddPackage: aCollection ].
	self project announceChanged.
]

{ #category : #updating }
PBAssembly >> addPart: aPackageNameOraPackageVersionReference [ 
	| pkgVersionRef constraints |
	pkgVersionRef := aPackageNameOraPackageVersionReference asPackageVersionReference.
	constraints := pkgVersionRef versionNumber 
		ifNil: [ #() ]
		ifNotNil: [ Array with: '=' , pkgVersionRef versionString ].
	packages add: (CGOPackageDependency newFrom: pkgVersionRef packageName  -> constraints)
]

{ #category : #accessing }
PBAssembly >> allPackageUnits [
	" returns the list of package units part of the assembly recursively, flattening package assemblies"
	
	| units |
	units := (self assemblies flatCollect: #allPackageUnits as: Set).
	units addAll: self packageUnits.
	^ units
]

{ #category : #converting }
PBAssembly >> asSerializedPackage [
	"Package repository version of the assembly metadata (i.e. full metadata)"
	^ PBSerializedAssembly from: self
]

{ #category : #converting }
PBAssembly >> asVcsSerializedPackageAssembly [
	"VCS version of the unit metadata (i.e. minimum metadata)"
	^ PBVcsSerializedPackageAssembly from: self
]

{ #category : #accessing }
PBAssembly >> assemblies [
	^ self partsFromRegistry: [ :each | each notNil and: [ each isAssembly ] ]
]

{ #category : #packages }
PBAssembly >> createPackageNamed: aString [ 
	
	^ self addPackage: (self project createPackageNamed: aString)
]

{ #category : #accessing }
PBAssembly >> dependencies [
	"for polymorphism with Package Unit"
	^ self parts
]

{ #category : #adding }
PBAssembly >> doAddPackage: aPackage [
	
	"Low level. Modifies the assembly without announcing changes.
	Use with care"
	
	"An assembly should only contain packages of the same project"
	self assert: (aPackage project = self project).
	^ packages add: aPackage
]

{ #category : #comparing }
PBAssembly >> hash [

	^ self name hash
]

{ #category : #initialization }
PBAssembly >> initializeFromPackageVersion: aCGOPackageVersion [
	self initialize.
	packages := aCGOPackageVersion dependencies collect: #copy as: OrderedCollection.

]

{ #category : #initialization }
PBAssembly >> initializeFromVcsSerializedPackage: aCGOVcsSerializedPackageAssembly [ 
	"The project will be set later by CGOVcsSerializedProject>>#flushIn:"
	super initializeWithPackageName: aCGOVcsSerializedPackageAssembly name andProject: nil.
	packages := self deserializedDependencies: aCGOVcsSerializedPackageAssembly parts.
]

{ #category : #initialization }
PBAssembly >> initializeWithPackageName: aPackageName andProject: aCargoProject [
	
	name := aPackageName.
	project := aCargoProject.
	packages := OrderedCollection new.
]

{ #category : #testing }
PBAssembly >> isAssembly [
	^ true
]

{ #category : #testing }
PBAssembly >> isEmpty [
	^ self parts isEmpty
]

{ #category : #'querying - installed' }
PBAssembly >> isInstalled [
	
	^ (self parts collect: #asPackageDependency) allSatisfy: #isInstalled
]

{ #category : #'support-ui' }
PBAssembly >> packageCandidates [
	
	"Return the possible packages that can be added to this assembly"
	^ self project packages difference: self packages
]

{ #category : #accessing }
PBAssembly >> packageNames [
	^ self packageUnits collect: #packageName
]

{ #category : #accessing }
PBAssembly >> packageUnits [
	^ self partsFromRegistry: [ :each | each notNil and: [ each isUnit ] ]
]

{ #category : #accessing }
PBAssembly >> packages [

	^ packages
]

{ #category : #accessing }
PBAssembly >> parts [
	^ packages
]

{ #category : #updating }
PBAssembly >> parts: aListOfCGOPackageDependency [
	packages := aListOfCGOPackageDependency
]

{ #category : #private }
PBAssembly >> partsFromRegistry: filterBlock [
	^ packages
		collect: [ :each | 
			self project registry 
				packageNamed: each fullyQualifiedName 
				ifAbsent: [ CGOPackageNotFoundError signal: each packageName ] ]
		thenSelect: filterBlock
]

{ #category : #actions }
PBAssembly >> remove [
	
	project removeAssembly: self
]

{ #category : #packages }
PBAssembly >> removePackage: aPBPackage [ 
	
	packages remove: aPBPackage
]

{ #category : #package }
PBAssembly >> removePackage: aPBPackage ifAbsent: aBlockClosure [
	
	packages remove: aPBPackage ifAbsent: aBlockClosure
]

{ #category : #updating }
PBAssembly >> removePart: aCGOPackageDependency [ 
	packages remove: aCGOPackageDependency
]
