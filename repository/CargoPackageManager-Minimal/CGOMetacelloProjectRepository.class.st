Class {
	#name : #CGOMetacelloProjectRepository,
	#superclass : #Object,
	#instVars : [
		'repository',
		'packageVersions'
	],
	#category : 'CargoPackageManager-Minimal-Model'
}

{ #category : #'versions fetching' }
CGOMetacelloProjectRepository >> fetch: aPackageName version: aVersion [
	^ packageVersions 
		detect: [ :each | 
					(each packageName = aPackageName) and: [ each version = aVersion asSemanticVersion ] ]
		ifNone: [ CGOPackageVersionNotFoundError signal ]
]

{ #category : #initialization }
CGOMetacelloProjectRepository >> initialize [
	packageVersions := OrderedCollection new.
]

{ #category : #testing }
CGOMetacelloProjectRepository >> isVirtual: aPackageName [
	^ false
]

{ #category : #'versions fetching' }
CGOMetacelloProjectRepository >> latestVersionOfPackage: aPackageName suitableForEnvironment: platformAttributes [ 
	"just pick the current version in the SCM"
	^ (self package: aPackageName) asPackageVersionReference
]

{ #category : #'private-monticello' }
CGOMetacelloProjectRepository >> mcVersionFor: aCGOMetacelloProject [
	self flag: 'todo'.
	aCGOMetacelloProject load.
]

{ #category : #accessing }
CGOMetacelloProjectRepository >> package: aPackageName [
	^ packageVersions 
		detect: [ :each | each packageName = aPackageName ]
		ifNone: [ CGOPackageNotFoundError signal: aPackageName ]
]

{ #category : #'versions fetching' }
CGOMetacelloProjectRepository >> packagesProviding: aName version: aSemanticVersion forEnvironment: platformAttributes [
	"We ignore virtual packages asthey do not exist in Metacello."
	^ #()
]

{ #category : #adding }
CGOMetacelloProjectRepository >> registerProjectFromSourceRepository: aCGOMetacelloProjectRepository [
	| project |
	project := PBMetacelloProject fromRepository: aCGOMetacelloProjectRepository.
	packageVersions add: project.
	^ project

]
