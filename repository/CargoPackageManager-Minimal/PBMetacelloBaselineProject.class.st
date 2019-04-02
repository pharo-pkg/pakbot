"
I represent a Metacello Project using a BaselineOf and act as a Cargo project.

	self exampleConfiguration inspect
"
Class {
	#name : #PBMetacelloBaselineProject,
	#superclass : #PBMetacelloProject,
	#category : #'CargoPackageManager-Minimal-Model'
}

{ #category : #loading }
PBMetacelloBaselineProject >> basicLoad [

	Metacello new 
		repository: self metacelloUrl;
		baseline: name;
		load: packageNames asArray.
]

{ #category : #initialization }
PBMetacelloBaselineProject >> initialize [
	super initialize.
]

{ #category : #accessing }
PBMetacelloBaselineProject >> isConfiguration [
	^ true
]

{ #category : #accessing }
PBMetacelloBaselineProject >> metacelloUrl [
	| url |
	(repository beginsWith: 'git@')
		ifTrue: [ 
			url := repository copyReplaceAll: 'github.com:' with: 'github.com/'.
			url := ('git+ssh://', url) asZnUrl ]
		ifFalse: [ url := repository asZnUrl ].
	^ String streamContents: [ :stream |
		url host = 'github.com'
			ifTrue: [ stream nextPutAll: 'github://' ].
		url host = 'gitlab.com'
			ifTrue: [ stream nextPutAll: 'gitlab://' ].
		url host = 'bitbucket.org'
			ifTrue: [ stream nextPutAll:'bitbucket://' ].
	
		stream nextPutAll: (($/ join: url segments) withoutSuffix: '.git').
		version ifNotNil: [ stream nextPut: $:; nextPutAll: version ] .
		"subdirectory ifNotNil: [ stream nextPutAll: subdirectory ]" ]
		

]

{ #category : #accessing }
PBMetacelloBaselineProject >> resolvedVersion [
	^ self version
]
