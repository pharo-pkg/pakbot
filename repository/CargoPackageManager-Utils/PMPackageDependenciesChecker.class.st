"
Utility class to easily compute dependencies of an image and generate associated metadata.

DAPackageDependenciesChecker new inspect.

examples:

self sortedTopGroupsWithAtLeast: 3.
self updateDependenciesOf: #Kernel.
self 
	packagesBeginningWith: #(#Kernel #Collection) 
	do: [ :each | self updateDependenciesOf: each key ]
"
Class {
	#name : #PMPackageDependenciesChecker,
	#superclass : #Object,
	#instVars : [
		'imageDependencies'
	],
	#category : 'CargoPackageManager-Utils'
}

{ #category : #'compute - dependencies' }
PMPackageDependenciesChecker >> buildImageDependencyMap [
	imageDependencies := (self imagePackageDependencies
		collect: [ :each | 
			each packageName -> (each dependencies collect: [:dep | dep target packageName] as: Array) ])
		asDictionary
]

{ #category : #'compute - dependencies' }
PMPackageDependenciesChecker >> dependenciesForPackagesNamed: aNameList [
	^ ((DAPackageRelationGraph onPackagesNamed: aNameList)
		build;
		packages)
	select: #isSeen
]

{ #category : #'compute - clustering' }
PMPackageDependenciesChecker >> groupCandidates [
	^ self imageDependencies values 
		flatCollect: [ :each | self groupCandidatesFor: each ]
		as: Set 
]

{ #category : #'compute - clustering' }
PMPackageDependenciesChecker >> groupCandidatesFor: aCollection [
	| result |
	result := OrderedCollection new.
	
	1 to: aCollection size -1 do: 
		[ :i | 
		result addAll:
			(self groupCandidatesWithFirstElementFor: (aCollection copyFrom: i to: aCollection size)) ].
	^ result asSet
]

{ #category : #'compute - clustering' }
PMPackageDependenciesChecker >> groupCandidatesWithFirstElementFor: aCollection [
	| result |
	result := OrderedCollection new: aCollection size -1.
	2 to: aCollection size do: 
		[ :i | 
		result add: (aCollection copyFrom: 1 to: i) asSet ].
	^ result
]

{ #category : #accessing }
PMPackageDependenciesChecker >> imageDependencies [
	imageDependencies ifNil: [ self buildImageDependencyMap ].
	^ imageDependencies 
]

{ #category : #'compute - dependencies' }
PMPackageDependenciesChecker >> imagePackageDependencies [
	^ self dependenciesForPackagesNamed: RPackage organizer packageNames
]

{ #category : #accessing }
PMPackageDependenciesChecker >> manifestOf: aPackageName [
	^ (RPackage named: aPackageName) packageManifest
]

{ #category : #accessing }
PMPackageDependenciesChecker >> ongoingPackageUnitOf: aPackageName [
	| manifest ongoing |
	manifest := self manifestOf: aPackageName.
	ongoing := CGOOngoingPackage on: manifest.
	(manifest class selectors includes: #packageName)
		ifFalse: [ ongoing updatePackageName: aPackageName ].
	^ ongoing

]

{ #category : #updating }
PMPackageDependenciesChecker >> packagesBeginningWith: aListOfPrefix do: aBlock [ 
	(self imageDependencies associationsSelect: 
		[ :assoc | aListOfPrefix anySatisfy: [ :prefix | assoc key beginsWith: prefix ] ])
		associationsDo: [ :each | aBlock value: each ]
]

{ #category : #accessing }
PMPackageDependenciesChecker >> sortedTopGroupsWithAtLeast: numberOfDependencies [
	^ (self topGroups 
		reject: [ :each | each value < numberOfDependencies ]) 
			sorted: [ :a :b | a value > b value ]
]

{ #category : #'compute - clustering' }
PMPackageDependenciesChecker >> topGroups [
	^ self groupCandidates collect: 
		[ :each |
		each -> (self imageDependencies values sum: 
			[ :aDependencySet | (aDependencySet includesAll: each) ifTrue: [ 1 ] ifFalse: [ 0 ] ]) ]
]

{ #category : #updating }
PMPackageDependenciesChecker >> updateDependenciesOf: aPackageName [
	(self ongoingPackageUnitOf: aPackageName) 
		dependencies: ((self imageDependencies at: aPackageName)
			collect: #asPackageDependency
			as: Array)
]
