"
I'm the bridge betwwen Calypso and Cargo allowing Calypso to query me to  get the list of projects and packages.
"
Class {
	#name : #CGOCalypsoPackageManager,
	#superclass : #ClyPackageManager,
	#instVars : [
		'cargoRegistry'
	],
	#category : 'CargoPackageManager-Calypso-Environment'
}

{ #category : #initialization }
CGOCalypsoPackageManager class >> initialize [
	ClySystemEnvironment currentImage 
		registerPackageManager: (self registry: CGOPackageRegistry default)
]

{ #category : #'instance creation' }
CGOCalypsoPackageManager class >> registry: aCGOPackageRegistry [
	^ self new 
		cargoRegistry: aCGOPackageRegistry
]

{ #category : #accessing }
CGOCalypsoPackageManager >> cargoRegistry [
	^ cargoRegistry
]

{ #category : #accessing }
CGOCalypsoPackageManager >> cargoRegistry: anObject [
	cargoRegistry := anObject
]

{ #category : #operations }
CGOCalypsoPackageManager >> createProjectNamed: aString [
	| project |
	project := CGOOngoingProject named: aString asSymbol.
	cargoRegistry register: project
]

{ #category : #accessing }
CGOCalypsoPackageManager >> dependenciesOf: systemPackage [
	| package |
	package := cargoRegistry packageNamed: systemPackage name.
	^ package dependencies 
		collect: [ :dependency |
			cargoRegistry packageNamed: dependency packageName ifAbsent: [ nil ] ]
		thenSelect: #notNil
]

{ #category : #accessing }
CGOCalypsoPackageManager >> packageNamed: aSymbol [
	^ ClyManagedPackage 
			for: (systemEnvironment packageNamed: aSymbol) 
			managedBy: self
]

{ #category : #accessing }
CGOCalypsoPackageManager >> packageOf: aCGOPackageUnit [
	^ self packageNamed: aCGOPackageUnit packageName
]

{ #category : #accessing }
CGOCalypsoPackageManager >> packagesOf: aCGOProject [
	^ aCGOProject packageUnits
		collect: [ :each | self packageOf: each ]
]

{ #category : #accessing }
CGOCalypsoPackageManager >> projectItemsOf: aCGOProject [
	^ (self packagesOf: aCGOProject), 
		(aCGOProject assemblies collect: [:each | 
			CGOClyPackageAssembly of: (self projectOf: each) on: each]), 
		(aCGOProject virtualPackages collect: [:each | 
			CGOClyVirtualPackage of: (self projectOf: each) on: each])
]

{ #category : #accessing }
CGOCalypsoPackageManager >> projectOf: aCGOPackageVersion [
	^ ClyManagedProject
		for: aCGOPackageVersion project 
		named: aCGOPackageVersion packageName 
		managedBy: self
]

{ #category : #accessing }
CGOCalypsoPackageManager >> projects [
	^ cargoRegistry registeredProjects 
		collect: 	[ :each | ClyManagedProject for: each named: each packageName managedBy: self]
]

{ #category : #operations }
CGOCalypsoPackageManager >> saveProject: aCGOProject toSCMWithMessage: message [ 
	aCGOProject asOngoingPackage saveToSCM: message
]

{ #category : #accessing }
CGOCalypsoPackageManager >> versionOf: systemPackage [
	^ cargoRegistry packageNamed: systemPackage name
]
