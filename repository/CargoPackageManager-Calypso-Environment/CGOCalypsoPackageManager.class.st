"
I'm the bridge betwwen Calypso and Cargo allowing Calypso to query me to  get the list of projects and packages.
"
Class {
	#name : #CGOCalypsoPackageManager,
	#superclass : #ClyProjectManager,
	#instVars : [
		'registry'
	],
	#category : #'CargoPackageManager-Calypso-Environment'
}

{ #category : #'instance creation' }
CGOCalypsoPackageManager class >> forRegistry: aCGOPackageRegistry [

	^ self new
		cargoRegistry: aCGOPackageRegistry;
		yourself
]

{ #category : #initialization }
CGOCalypsoPackageManager class >> initialize [
	ClySystemEnvironment currentImage registerProjectManager: self new
]

{ #category : #accessing }
CGOCalypsoPackageManager >> cargoRegistry [
	^ registry ifNil: [ CGOPackageRegistry default ]
]

{ #category : #accessing }
CGOCalypsoPackageManager >> cargoRegistry: aRegistry [
	
	registry := aRegistry
]

{ #category : #operations }
CGOCalypsoPackageManager >> createProjectNamed: aString [

	^ self cargoRegistry newProjectNamed: aString

]

{ #category : #accessing }
CGOCalypsoPackageManager >> dependenciesOf: systemPackage [
	| package |
	package := self cargoRegistry packageNamed: systemPackage name.
	^ package dependencies 
		collect: [ :dependency |
			self cargoRegistry packageNamed: dependency packageName ifAbsent: [ nil ] ]
		thenSelect: #notNil
]

{ #category : #accessing }
CGOCalypsoPackageManager >> packageNamed: aSymbol [
	self halt.
	^ PBPackageUIItem 
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
	1halt.
	^ ClyManagedProject
		for: aCGOPackageVersion project 
		named: aCGOPackageVersion packageName 
		managedBy: self
]

{ #category : #accessing }
CGOCalypsoPackageManager >> projects [
	^ self cargoRegistry registeredProjects 
		collect: 	[ :each | PBProjectUIItem forProject: each]
]

{ #category : #'api - queries' }
CGOCalypsoPackageManager >> queryClass [
	
	^ PBAllPakbotProjects
]

{ #category : #operations }
CGOCalypsoPackageManager >> saveProject: aCGOProject toSCMWithMessage: message [ 
	aCGOProject asOngoingPackage saveToSCM: message
]

{ #category : #accessing }
CGOCalypsoPackageManager >> systemEnvironment: anEnvironment [
]

{ #category : #accessing }
CGOCalypsoPackageManager >> versionOf: systemPackage [
	^ self cargoRegistry packageNamed: systemPackage name
]
