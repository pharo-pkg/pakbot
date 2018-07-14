"
A simple object used to parse a version reference
"
Class {
	#name : #CGOVersionReference,
	#superclass : #Object,
	#instVars : [
		'packageName',
		'branch',
		'author',
		'versionNumber'
	],
	#category : 'CargoPackageManager-TestRessources-Resources'
}

{ #category : #'instance creation' }
CGOVersionReference class >> named: aPackageVersionReferenceString [
	^ self basicNew
		initializeWithName: aPackageVersionReferenceString;
		yourself
]

{ #category : #accessing }
CGOVersionReference >> author [
	^ author
]

{ #category : #accessing }
CGOVersionReference >> branch [
	^ branch
]

{ #category : #initialization }
CGOVersionReference >> initializeWithName: aName [
	"Duplicated from GoferVersionReference to avoid a dependency"
	| basicName |
	
	super initialize.
	basicName := aName last isDigit
		ifTrue: [ aName ]
		ifFalse: [ (aName copyUpToLast: $.) copyUpTo: $( ].
	packageName := basicName copyUpToLast: $-.
	(packageName includes: $.)
		ifFalse: [ branch := '' ]
		ifTrue: [
			branch := packageName copyAfter: $..
			packageName := packageName copyUpTo: $. ].
	author := (basicName copyAfterLast: $-) copyUpToLast: $..
	versionNumber := (basicName copyAfterLast: $-) copyAfterLast: $..
	(versionNumber notEmpty and: [ versionNumber allSatisfy: [ :each | each isDigit ] ])
		ifTrue: [ versionNumber := versionNumber asInteger ]
		ifFalse: [ versionNumber := 0 ]
]

{ #category : #accessing }
CGOVersionReference >> packageName [
	^ packageName
]

{ #category : #printing }
CGOVersionReference >> printOn: aStream [
	aStream 
		nextPutAll: packageName;
		nextPut: $-.
	branch = ''
		ifFalse: [
			aStream
				nextPutAll: branch;
				nextPut: $- ].
	aStream
		nextPutAll: author;
		nextPut: $.;
		print: versionNumber
]

{ #category : #accessing }
CGOVersionReference >> versionNumber [
	^ versionNumber
]
