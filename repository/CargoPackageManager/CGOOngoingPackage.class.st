"
Current version of the package unit metadata. As a PackageVersion is not editable, it is the only way  to update it.
"
Class {
	#name : #CGOOngoingPackage,
	#superclass : #CGOProjectElement,
	#instVars : [
		'provisions',
		'platformRequirements'
	],
	#category : #'CargoPackageManager-Model'
}

{ #category : #example }
CGOOngoingPackage class >> example [
	^ (self named: #UnitTest project: (CGOOngoingProject named: #MyProject))
		description: 'A simple ongoing package unit.';
		yourself
]

{ #category : #comparing }
CGOOngoingPackage >> = anotherPackage [

	self species = anotherPackage species ifFalse: [ ^ false ].
	self name = anotherPackage name ifFalse: [ ^ false ].
	^ self project = anotherPackage project
]

{ #category : #updating }
CGOOngoingPackage >> addDependencyOn: aPackageName [ 
	dependencies	add:
		(CGOPackageDependency on: aPackageName)
]

{ #category : #'accessing - dependencies' }
CGOOngoingPackage >> allDependencies [
	
	^ dependencies
]

{ #category : #converting }
CGOOngoingPackage >> asPackageDependency [
	^ (self packageName -> {('=', self version asString)}) asPackageDependency
		project: project;
		yourself
]

{ #category : #converting }
CGOOngoingPackage >> asPackageVersionOf: aCGOProject [
	^ CGOPackageUnit fromOngoing: self project: aCGOProject
]

{ #category : #converting }
CGOOngoingPackage >> asVcsSerializedPackageUnit [
	"VCS version of the unit metadata (i.e. minimum metadata)"
	^ CGOVcsSerializedPackageUnit from: self
]

{ #category : #accessing }
CGOOngoingPackage >> dependencies [
	^ dependencies
]

{ #category : #updating }
CGOOngoingPackage >> dependencies: aDependencyList [ 
	dependencies := aDependencyList
]

{ #category : #testing }
CGOOngoingPackage >> fitsPlatformRequirements [
	^ Cargo platformAttributes includesAll: platformRequirements
]

{ #category : #comparing }
CGOOngoingPackage >> hash [

	^ self name hash
]

{ #category : #initialization }
CGOOngoingPackage >> initializeFromPackageVersion: aCGOPackageVersion [
	self initialize.
	dependencies := aCGOPackageVersion dependencies collect: #copy as: OrderedCollection.
	self provisions: aCGOPackageVersion provisions.
	platformRequirements := aCGOPackageVersion platformRequirements asOrderedCollection.
]

{ #category : #initialization }
CGOOngoingPackage >> initializeWithPackageName: aPackageName andProject: aCargoProject [
	
	name := aPackageName.
	project := aCargoProject.
	dependencies := OrderedCollection new.
	provisions := OrderedCollection new: 0.
	platformRequirements := OrderedCollection new: 0.	
]

{ #category : #'querying - installed' }
CGOOngoingPackage >> isInstalled [
	
	^ project registry isInstalled: self
]

{ #category : #testing }
CGOOngoingPackage >> isUnit [
	^ true
]

{ #category : #accessing }
CGOOngoingPackage >> platformRequirements [
	^ platformRequirements
]

{ #category : #updating }
CGOOngoingPackage >> platformRequirements: aListOfSymbols [ 
	platformRequirements := aListOfSymbols
]

{ #category : #'testing - installing' }
CGOOngoingPackage >> providesPackage: aPackageDependency [ 
	
	^ self packageName = aPackageDependency packageName and: [ aPackageDependency satisfyConstraints: self version ]
]

{ #category : #accessing }
CGOOngoingPackage >> provisions [
	^ provisions
]

{ #category : #updating }
CGOOngoingPackage >> provisions: aListOfVirtualPackageVersionsReference [ 
	provisions := (CGOPackageUnit provisionsFromListOfProvisionStrings: aListOfVirtualPackageVersionsReference)	asOrderedCollection
]

{ #category : #constrains }
CGOOngoingPackage >> removeDependency: aPackageDependency [
	dependencies := dependencies 
		reject: [ :dependency | dependency packageName = aPackageDependency packageName ]
]

{ #category : #updating }
CGOOngoingPackage >> updateDependency: aPackageDependency [
	dependencies := dependencies collect: 
		[ :dependency | 
		(dependency packageName = aPackageDependency packageName)
			ifTrue: [ aPackageDependency ]
			ifFalse: [ dependency ] ]
]

{ #category : #'*CargoPackageManager' }
CGOOngoingPackage >> versionLoaded [
	self repository versionLoaded: self packageName.
]
