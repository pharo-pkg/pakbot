"
I represent a package version containing source code.
The source code can be hosted on different backends: git, monticello. 

-- repository is the Cargo respository abstraction where you can find this package version
- packageName is the name of the source code package (in most cases, will be the same as the Cargo package name)
"
Class {
	#name : #CGOSourcePackageVersion,
	#superclass : #Object,
	#instVars : [
		'repository',
		'packageName'
	],
	#category : 'CargoPackageManager-Loading'
}

{ #category : #private }
CGOSourcePackageVersion class >> classFor: aCGOSourceRepository [ 
	^ aCGOSourceRepository sourcePackageVersionClass
]

{ #category : #'instance creation' }
CGOSourcePackageVersion class >> repository: aCGOSourceRepository packageName: aPackageName [
	^ (self classFor: aCGOSourceRepository) basicNew 
		repository: aCGOSourceRepository packageName: aPackageName;
		yourself
]

{ #category : #accessing }
CGOSourcePackageVersion >> mcVersion [
	self subclassResponsibility
]

{ #category : #accessing }
CGOSourcePackageVersion >> packageName [
	^ packageName
]

{ #category : #fetching }
CGOSourcePackageVersion >> projectMetadataStonString [
	^ repository projectMetadataStonString
]

{ #category : #initialization }
CGOSourcePackageVersion >> repository: aCGOGitRepository packageName: aPackageName [ 
	repository := aCGOGitRepository.
	packageName := aPackageName
]
