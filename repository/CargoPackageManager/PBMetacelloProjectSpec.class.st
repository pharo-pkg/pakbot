"
I represent a Metacello project spec, i.e. the declaration of an external project.
See my superclass for more information.
"
Class {
	#name : #PBMetacelloProjectSpec,
	#superclass : #PBMetacelloSpec,
	#instVars : [
		'version',
		'loads',
		'repository',
		'definedByBaseline'
	],
	#category : #'CargoPackageManager-Metacello'
}

{ #category : #configuring }
PBMetacelloProjectSpec >> beBaseline [
	
	definedByBaseline := true
]

{ #category : #configuring }
PBMetacelloProjectSpec >> beConfiguration [
	
	definedByBaseline := false
]

{ #category : #testing }
PBMetacelloProjectSpec >> isBaseline [
	
	^ definedByBaseline
]

{ #category : #testing }
PBMetacelloProjectSpec >> isPackageSpec [

	^ false
]

{ #category : #accessing }
PBMetacelloProjectSpec >> loads [

	^ loads
]

{ #category : #accessing }
PBMetacelloProjectSpec >> loads: anObject [

	loads := anObject
]

{ #category : #accessing }
PBMetacelloProjectSpec >> repository [

	^ repository
]

{ #category : #accessing }
PBMetacelloProjectSpec >> repository: anObject [

	repository := anObject
]

{ #category : #accessing }
PBMetacelloProjectSpec >> version [

	^ version
]

{ #category : #accessing }
PBMetacelloProjectSpec >> version: anObject [

	version := anObject
]
