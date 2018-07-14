"
This class represents a symbolic version as expressed in semantic versionning.
The format is MAJOR.MINOR.PATCH.
examples:
	1.2.0
	1.1
	1.0-RC1

Given a version number MAJOR.MINOR.PATCH, increment the:
- MAJOR version when you make incompatible API changes,
- MINOR version when you add functionality in a backwards-compatible manner, and
- PATCH version when you make backwards-compatible bug fixes.

Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

See http://semver.org/ for more details.
"
Class {
	#name : #SemanticVersion,
	#superclass : #Object,
	#instVars : [
		'major',
		'minor',
		'patch',
		'suffix'
	],
	#category : 'CargoPackageManager-Minimal-Model'
}

{ #category : #'instance creation' }
SemanticVersion class >> fromString: aString [
	"Answer the parts of aString, expected in short format <major>.<minor>.<patch>"
	| parts version majorNumber minorNumber patchNumber suffixString |

	aString ifNil: [ ^ self ].
	
	version := self new.
	parts := $. split: aString.
	(parts size > 3) ifTrue: [ SemanticVersionFormatError signal: aString ].
	
	majorNumber := (parts at: 1) asInteger.
	majorNumber ifNil: [ SemanticVersionFormatError signal: 'Wrong major format' ].
	[ minorNumber := (parts at: 2) asInteger.
	minorNumber ifNil: [ SemanticVersionFormatError signal: 'Wrong minor format' ].
	patchNumber := (parts at: 3) asInteger. ]
		on: SubscriptOutOfBounds
		do: [ "if minor and/or patch version is not specified, keep nil" ].
	suffixString := self suffixFrom: parts last.
	version 
		initializeWithMajor: majorNumber
		minor: minorNumber
		patch: patchNumber
		suffix: suffixString.
		
	^ version
]

{ #category : #private }
SemanticVersion class >> suffixFrom: aString [
	"discard all numbers until another character is found."
	| regex |

	regex := '([0-9]+)(.*)' asRegex.
	regex matches: aString.
	^ (regex subexpression: 3) ifEmpty: [ nil ]
]

{ #category : #comparing }
SemanticVersion >> = other [
	(self major = other major) ifFalse: [ ^ false ].
	(self minor = other minor) ifFalse: [ ^ false ].
	(self patch = other patch) ifFalse: [ ^ false ].
	(self suffix = other suffix) ifFalse: [ ^ false ].
	^ true
]

{ #category : #comparing }
SemanticVersion >> > other [ 
	(self major > other major) ifTrue: [ ^ true ].
	(self major < other major) ifTrue: [ ^ false ].
	(self minor > other minor) ifTrue: [ ^ true ].
	(self minor < other minor) ifTrue: [ ^ false ].
	(self patch > other patch) ifTrue: [ ^ true ].
	(self patch < other patch) ifTrue: [ ^ false ].
	^ self suffix 
		ifNil: [ ^ other suffix isNotNil ]
		ifNotNil: [ other suffix
					ifNil: [ false ]
					ifNotNil: [ self suffix > other suffix ]  ]
]

{ #category : #converting }
SemanticVersion >> asSemanticVersion [
	^ self
]

{ #category : #comparing }
SemanticVersion >> hash [
	^ self printString hash
]

{ #category : #initialization }
SemanticVersion >> initialize [
	super initialize.
	minor := 0.
	patch := 0
]

{ #category : #initialization }
SemanticVersion >> initializeWithMajor: majorNumber minor: minorNumber patch: patchNumber suffix: suffixString [
	super initialize.
	major := majorNumber.
	minorNumber 
		ifNil: [ 0 ]
		ifNotNil: [ minor := minorNumber ].
	patchNumber
		ifNil: [ 0 ]
		ifNotNil: [ patch := patchNumber ].
	suffixString ifNotNil: [ suffix := suffixString ]
]

{ #category : #testing }
SemanticVersion >> isDevelopmentVersion [
	^ suffix 
		ifNil: [ false ]
		ifNotNil: [ suffix endsWith: '-dev' ]
]

{ #category : #accessing }
SemanticVersion >> major [
	^ major
]

{ #category : #accessing }
SemanticVersion >> minor [
	^ minor
]

{ #category : #accessing }
SemanticVersion >> patch [
	^ patch
]

{ #category : #printing }
SemanticVersion >> printOn: aStream [
	aStream << major.
	minor ifNil: [ ^self ].
	aStream << $. << minor.
	patch ifNil: [ ^self ].
	aStream << $. << patch.
	suffix ifNotNil: [ aStream << suffix ]
]

{ #category : #ston }
SemanticVersion >> stonOn: stonWriter [
	stonWriter writeString: self asString
]

{ #category : #accessing }
SemanticVersion >> suffix [
	^ suffix
]
