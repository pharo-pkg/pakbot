"
Current version of the package unit metadata. As a PackageVersion is not editable, it is the only way  to update it.
"
Class {
	#name : #PBPackage,
	#superclass : #PBProjectElement,
	#instVars : [
		'provisions',
		'platformRequirements'
	],
	#category : #'CargoPackageManager-Model'
}

{ #category : #example }
PBPackage class >> example [
	^ (self named: #UnitTest project: (PBProject named: #MyProject))
		description: 'A simple ongoing package unit.';
		yourself
]

{ #category : #comparing }
PBPackage >> = anotherPackage [

	self species = anotherPackage species ifFalse: [ ^ false ].
	self name = anotherPackage name ifFalse: [ ^ false ].
	^ self project = anotherPackage project
]

{ #category : #adding }
PBPackage >> addDependencyOn: aPackageName [
	self addDependency: (CGOPackageDependency on: aPackageName)
]

{ #category : #'accessing - dependencies' }
PBPackage >> allDependencies [
	
	^ dependencies
]

{ #category : #converting }
PBPackage >> asPackageDependency [
	^ (self name -> {('=', self version asString)}) asPackageDependency
		project: project;
		yourself
]

{ #category : #converting }
PBPackage >> asVcsSerializedPackageUnit [
	"VCS version of the unit metadata (i.e. minimum metadata)"
	^ CGOVcsSerializedPackageUnit from: self
]

{ #category : #'private-loading' }
PBPackage >> basicLoad [

	self repository loadPackageNamed: self name
]

{ #category : #accessing }
PBPackage >> dependencies [
	^ dependencies
]

{ #category : #updating }
PBPackage >> dependencies: aDependencyList [ 
	dependencies := aDependencyList
]

{ #category : #testing }
PBPackage >> fitsPlatformRequirements [
	^ Cargo platformAttributes includesAll: platformRequirements
]

{ #category : #comparing }
PBPackage >> hash [

	^ self name hash
]

{ #category : #initialization }
PBPackage >> initializeFromPackageVersion: aCGOPackageVersion [
	self initialize.
	dependencies := aCGOPackageVersion dependencies collect: #copy as: OrderedCollection.
	self provisions: aCGOPackageVersion provisions.
	platformRequirements := aCGOPackageVersion platformRequirements asOrderedCollection.
]

{ #category : #initialization }
PBPackage >> initializeWithPackageName: aPackageName andProject: aCargoProject [
	self initialize.
	name := aPackageName.
	project := aCargoProject.
	provisions := OrderedCollection new: 0.
	platformRequirements := OrderedCollection new: 0.	
]

{ #category : #'querying - installed' }
PBPackage >> isInstalled [
	
	^ self isLoaded
]

{ #category : #'querying - installed' }
PBPackage >> isLoaded [
	
	project registry systemPackageOrganizer packageNamed: self name ifAbsent: [ ^false ].
	^ (project registry isInstalled: self)
]

{ #category : #testing }
PBPackage >> isUnit [
	^ true
]

{ #category : #accessing }
PBPackage >> platformRequirements [
	^ platformRequirements
]

{ #category : #updating }
PBPackage >> platformRequirements: aListOfSymbols [ 
	platformRequirements := aListOfSymbols
]

{ #category : #accessing }
PBPackage >> provisions [
	^ provisions
]

{ #category : #updating }
PBPackage >> provisions: aListOfVirtualPackageVersionsReference [ 
	provisions := (CGOPackageUnit provisionsFromListOfProvisionStrings: aListOfVirtualPackageVersionsReference)	asOrderedCollection
]

{ #category : #constrains }
PBPackage >> removeDependency: aPackageDependency [
	dependencies := dependencies 
		reject: [ :dependency | dependency packageName = aPackageDependency packageName ]
]

{ #category : #'system-package' }
PBPackage >> removePackageFromSystem [
	
	| systemPackage |
	systemPackage := self name asPackageIfAbsent: [ ^ self ].
	systemPackage removeFromSystem
]

{ #category : #'querying - installed' }
PBPackage >> satisfyConstraints: aVersion [ 

	^ aVersion = self version
]

{ #category : #accessing }
PBPackage >> systemPackage [
	
	^ RPackageOrganizer default packageNamed: self name
]

{ #category : #updating }
PBPackage >> updateDependency: aPackageDependency [
	dependencies := dependencies collect: 
		[ :dependency | 
		(dependency packageName = aPackageDependency packageName)
			ifTrue: [ aPackageDependency ]
			ifFalse: [ dependency ] ]
]

{ #category : #'*CargoPackageManager' }
PBPackage >> versionLoaded [
	self repository versionLoaded: self packageName.
]
