"
Current version of the package unit metadata. As a PackageVersion is not editable, it is the only way  to update it.
"
Class {
	#name : #CGOOngoingPackageUnit,
	#superclass : #CGOOngoingPackage,
	#instVars : [
		'dependencies',
		'provisions',
		'platformRequirements'
	],
	#category : 'CargoPackageManager-Model'
}

{ #category : #example }
CGOOngoingPackageUnit class >> example [
	^ (self named: #UnitTest)
		description: 'A simple ongoing package unit.';
		project: (CGOOngoingProject named: #MyProject);
		yourself
]

{ #category : #updating }
CGOOngoingPackageUnit >> addDependencyOn: aPackageName [ 
	dependencies	add:
		(CGOPackageDependency on: aPackageName)
]

{ #category : #'accessing - dependencies' }
CGOOngoingPackageUnit >> allDependencies [
	
	^ dependencies
]

{ #category : #converting }
CGOOngoingPackageUnit >> asPackageDependency [
	^ (self packageName -> {('=', self version asString)}) asPackageDependency
		project: project;
		yourself
]

{ #category : #converting }
CGOOngoingPackageUnit >> asPackageVersionOf: aCGOProject [
	^ CGOPackageUnit fromOngoing: self project: aCGOProject
]

{ #category : #converting }
CGOOngoingPackageUnit >> asVcsSerializedPackageUnit [
	"VCS version of the unit metadata (i.e. minimum metadata)"
	^ CGOVcsSerializedPackageUnit from: self
]

{ #category : #loading }
CGOOngoingPackageUnit >> basicLoad [
	self repository loadPackageNamed: self packageName
]

{ #category : #accessing }
CGOOngoingPackageUnit >> dependencies [
	^ dependencies
]

{ #category : #updating }
CGOOngoingPackageUnit >> dependencies: aDependencyList [ 
	dependencies := aDependencyList
]

{ #category : #testing }
CGOOngoingPackageUnit >> fitsPlatformRequirements [
	^ Cargo platformAttributes includesAll: platformRequirements
]

{ #category : #initialization }
CGOOngoingPackageUnit >> initializeFromPackageVersion: aCGOPackageVersion [
	super initialize.
	package := aCGOPackageVersion package.
	description := aCGOPackageVersion copy.
	dependencies := aCGOPackageVersion dependencies collect: #copy as: OrderedCollection.
	self provisions: aCGOPackageVersion provisions.
	platformRequirements := aCGOPackageVersion platformRequirements asOrderedCollection.
]

{ #category : #initialization }
CGOOngoingPackageUnit >> initializeWithPackageName: aPackageName andProject: aCargoProject [
	super initializeWithPackageName: aPackageName andProject: aCargoProject.
	dependencies := OrderedCollection new.
	provisions := OrderedCollection new: 0.
	platformRequirements := OrderedCollection new: 0.	
]

{ #category : #'querying - installed' }
CGOOngoingPackageUnit >> isInstalled [
	
	^ project registry isInstalled: self
]

{ #category : #'querying - Installed' }
CGOOngoingPackageUnit >> isProvidedBy: aPackageUnit [

	^ aPackageUnit providesPackage: self
]

{ #category : #testing }
CGOOngoingPackageUnit >> isUnit [
	^ true
]

{ #category : #accessing }
CGOOngoingPackageUnit >> name [
	
	^ package name
]

{ #category : #accessing }
CGOOngoingPackageUnit >> platformRequirements [
	^ platformRequirements
]

{ #category : #updating }
CGOOngoingPackageUnit >> platformRequirements: aListOfSymbols [ 
	platformRequirements := aListOfSymbols
]

{ #category : #'testing - installing' }
CGOOngoingPackageUnit >> providesPackage: aPackageDependency [ 
	
	^ self packageName = aPackageDependency packageName and: [ aPackageDependency satisfyConstraints: self version ]
]

{ #category : #accessing }
CGOOngoingPackageUnit >> provisions [
	^ provisions
]

{ #category : #updating }
CGOOngoingPackageUnit >> provisions: aListOfVirtualPackageVersionsReference [ 
	provisions := (CGOPackageUnit provisionsFromListOfProvisionStrings: aListOfVirtualPackageVersionsReference)	asOrderedCollection
]

{ #category : #constrains }
CGOOngoingPackageUnit >> removeDependency: aPackageDependency [
	dependencies := dependencies 
		reject: [ :dependency | dependency packageName = aPackageDependency packageName ]
]

{ #category : #'querying - installed' }
CGOOngoingPackageUnit >> satisfyConstraints: aVersion [ 

	^ aVersion = version
]

{ #category : #accessing }
CGOOngoingPackageUnit >> systemPackage [
	
	^ RPackageOrganizer default packageNamed: self name
]

{ #category : #updating }
CGOOngoingPackageUnit >> updateDependency: aPackageDependency [
	dependencies := dependencies collect: 
		[ :dependency | 
		(dependency packageName = aPackageDependency packageName)
			ifTrue: [ aPackageDependency ]
			ifFalse: [ dependency ] ]
]

{ #category : #'*CargoPackageManager' }
CGOOngoingPackageUnit >> versionLoaded [
	self repository versionLoaded: self packageName.
]
