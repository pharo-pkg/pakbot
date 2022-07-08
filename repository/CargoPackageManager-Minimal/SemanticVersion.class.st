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
	#category : #'CargoPackageManager-Minimal-Model-Versions'
}

{ #category : #'instance creation' }
SemanticVersion class >> fromString: aString [
	"Answer the parts of aString, expected in short format <major>.<minor>.<patch>"
	
	| matcher major minor patch suffix |
	matcher := self parsingRegex.
	(matcher matches: aString) ifFalse: [ ^ InvalidSemanticVersion fromString: aString ].
	
	major := (matcher subexpression: 2) asInteger.
	minor := (matcher subexpression: 4) ifNotNil: [ :string | string asInteger ].
	patch := (matcher subexpression: 6) ifNotNil: [ :string | string asInteger ].
	suffix := (matcher subexpression: 8).
	
	^ self new
		initializeWithMajor: major minor: minor patch: patch suffix: suffix;
		yourself.
	
]

{ #category : #accessing }
SemanticVersion class >> parsingRegex [
	^ 'v?(\d+)(\.(\d+)(\.(\d+))?)?(-(.+))?' asRegex
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
	self == other ifTrue: [ ^ true ].
	self species = other species ifFalse: [ ^ false ].

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
	minor := minorNumber.
	patch := patchNumber.
	suffix := suffixString
]

{ #category : #testing }
SemanticVersion >> isDevelopmentVersion [
	self flag:#todo.
	"The list of possibles suffix for dev should be bigger, also maybe case insensitive."
	^ suffix 
		ifNil: [ false ]
		ifNotNil: [ suffix endsWith: 'dev' ]
]

{ #category : #testing }
SemanticVersion >> isInvalid [
	^ false
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
	aStream << major asString.
	minor ifNil: [ ^self ].
	aStream << $. << minor asString.
	patch ifNil: [ ^self ].
	aStream << $. << patch asString.
	suffix ifNotNil: [ aStream << '-' << suffix ]
]

{ #category : #ston }
SemanticVersion >> stonOn: stonWriter [
	stonWriter writeString: self asString
]

{ #category : #accessing }
SemanticVersion >> suffix [
	^ suffix
]
