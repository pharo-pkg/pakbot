"
I represent a Metacello Project using a BaselineOf and act as a Cargo project.
```language=Pharo
	self example
```
"
Class {
	#name : #PBMetacelloBaselineProject,
	#superclass : #PBMetacelloProject,
	#category : #'Pakbot-Minimal-Metacello-Support'
}

{ #category : #example }
PBMetacelloBaselineProject class >> example [
	^ self 
		fromProjectDependency: PBMetacelloBaselineProjectDependency example
]

{ #category : #converting }
PBMetacelloBaselineProject >> asDependency [
	^ PBMetacelloBaselineProjectDependency
		name: self name
		repositoryUrl: self repository
		version: self version
]

{ #category : #loading }
PBMetacelloBaselineProject >> basicLoad [
	| metacello |
	
	metacello := Metacello new 
		repository: self metacelloUrl;
		baseline: name.
	
	packageNames 
		ifEmpty: [ metacello load ]
		ifNotEmpty: [ metacello load: packageNames asArray ].
]

{ #category : #loading }
PBMetacelloBaselineProject >> basicLoad: aListOfPackageName [
	aListOfPackageName 
		ifEmpty: [ ^ self. "packages are laready installed. DO NOT trigger a full install of the project" ].
	
	Metacello new 
		repository: self metacelloUrl;
		baseline: name;
		load: aListOfPackageName asArray.
]

{ #category : #accessing }
PBMetacelloBaselineProject >> fullVersionString [
	
	^ self version, ' (Baseline from ' , self repository , ')'
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
	^ repository asMetacelloRepositorySpec
		version: self version;
		asMetacelloUrl
]

{ #category : #accessing }
PBMetacelloBaselineProject >> resolvedVersion [
	^ self version
]

{ #category : #testing }
PBMetacelloBaselineProject >> satisfyConstraints: aVersionString [ 
	^ self asDependency satisfyConstraints: aVersionString
]
