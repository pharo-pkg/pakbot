"
I represent a Metacello Project using a BaselineOf and act as a Cargo project.
```language=Pharo
	self example
```
"
Class {
	#name : #PBMetacelloBaselineProject,
	#superclass : #PBMetacelloProject,
	#category : #'CargoPackageManager-Minimal-Model'
}

{ #category : #example }
PBMetacelloBaselineProject class >> example [
	^ self 
		fromProjectDependency: PBMetacelloBaselineProjectDependency example
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
	
	^ repository asMetacelloRepositorySpec asMetacelloUrl
]

{ #category : #accessing }
PBMetacelloBaselineProject >> resolvedVersion [
	^ self version
]
