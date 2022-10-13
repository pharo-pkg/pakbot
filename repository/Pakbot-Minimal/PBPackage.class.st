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
	#category : #'Pakbot-Minimal-Model'
}

{ #category : #example }
PBPackage class >> example [
	^ (self named: #UnitTest project: (PBProjectVersion named: #MyProject))
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
	self addDependency: (PBPackageDependency on: aPackageName)
]

{ #category : #'accessing - dependencies' }
PBPackage >> allDependencies [
	
	^ dependencies
]

{ #category : #accessing }
PBPackage >> allPackages [
	
	^ { self }
]

{ #category : #converting }
PBPackage >> asPackageDependency [
	^ (self name -> {('=', self version asString)}) asPackageDependency
		project: project;
		yourself
]

{ #category : #converting }
PBPackage >> asSerializedPackage [
	"Package repository version of the unit metadata (i.e. full metadata)"
	^ PBSerializedPackage from: self
]

{ #category : #converting }
PBPackage >> asVcsSerializedPackageUnit [
	"VCS version of the unit metadata (i.e. minimum metadata)"
	^ PBVcsSerializedPackageUnit from: self
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
	dependencies := aDependencyList.
	dependencies do: 
		[ :dependency |
			dependency 
				dependent: self;
				project: self project. ].
]

{ #category : #testing }
PBPackage >> fitsPlatformRequirements [
	^ Pakbot platformAttributes includesAll: platformRequirements
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
	
	project registry systemPackageOrganizer packageNamed: self name ifAbsent: [ ^false ].
	^ true
	" To avoid overriding of an existing system package, we do not check package registration in the registry."
]

{ #category : #testing }
PBPackage >> isLoadable [
	^ self satisfyPlatformRequirements: self registry currentPlatformRequirements
]

{ #category : #testing }
PBPackage >> isUnit [
	^ true
]

{ #category : #loading }
PBPackage >> load [

	self basicLoad.
	self registry register: self.
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
PBPackage >> project: aPBProjectVersion [ 

	super project: aPBProjectVersion.
	self dependencies do: [ :dep | dep project: aPBProjectVersion ].
]

{ #category : #accessing }
PBPackage >> provisions [
	^ provisions
]

{ #category : #updating }
PBPackage >> provisions: aListOfVirtualPackageVersionsReference [ 
	provisions := (CGOPackageUnit provisionsFromListOfProvisionStrings: aListOfVirtualPackageVersionsReference)	asOrderedCollection
]

{ #category : #dependencies }
PBPackage >> removeDependency: aDependency [
	dependencies remove: aDependency ifAbsent: [  ].
]

{ #category : #'system-package' }
PBPackage >> removePackageFromSystem [
	
	| systemPackage |
	systemPackage := self name asPackageIfAbsent: [ ^ self ].
	systemPackage removeFromSystem
]

{ #category : #solving }
PBPackage >> resolve [
	
	^ self project registry newSolver solvePackage: self
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

{ #category : #'as yet unclassified' }
PBPackage >> versionLoaded [
	self repository versionLoaded: self name.
]
