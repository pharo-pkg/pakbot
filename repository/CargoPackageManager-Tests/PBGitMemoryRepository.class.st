"
Fake Git repository used for test purposes.
No git repository is associated to me but I can hold a list of packages as if they were part of a git working copy.
"
Class {
	#name : #PBGitMemoryRepository,
	#superclass : #PBSourceRepository,
	#instVars : [
		'packages'
	],
	#category : #'CargoPackageManager-Tests-Model'
}

{ #category : #accessing }
PBGitMemoryRepository class >> type [
	^ #memory
]

{ #category : #'instance creation' }
PBGitMemoryRepository class >> url: aUrlString [

	^ self new
		url: aUrlString;
		yourself
]

{ #category : #updating }
PBGitMemoryRepository >> addPackageNamed: aPackageName [
	packages add: aPackageName
]

{ #category : #loading }
PBGitMemoryRepository >> fetchVersion: aString [ 
	
	"I'm a fake version. I will not fetch anything, just returning a fake project"
	^ (PBProjectVersion named: 'fake')
			version: aString;
			yourself
]

{ #category : #initialization }
PBGitMemoryRepository >> initialize [ 
	super initialize.
	packages := OrderedCollection new.
]

{ #category : #loading }
PBGitMemoryRepository >> loadPackageNamed: aString [ 
	(packages includes: aString)
		ifFalse: [ self error: 'package not found!' ]
]

{ #category : #updating }
PBGitMemoryRepository >> url: aUrlString [

	repositoryUrl := aUrlString
]
