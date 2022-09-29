"
I am a null object representing the absence of repository configured for a project.
"
Class {
	#name : #PBNoRepository,
	#superclass : #PBSourceRepository,
	#category : #'CargoPackageManager-Loading'
}

{ #category : #accessing }
PBNoRepository class >> type [
	^ #'NOTYPE'
]

{ #category : #updating }
PBNoRepository >> addPackageNamed: aPackageName [

	"no repository => do nothing"
]

{ #category : #accessing }
PBNoRepository >> description [
	
	^ 'No repository configured'
]

{ #category : #accessing }
PBNoRepository >> editionIconName [
	^ #edit
]

{ #category : #accessing }
PBNoRepository >> iconName [
	^ #smallCancel
]

{ #category : #testing }
PBNoRepository >> isValidRepository [
	
	^ false
]

{ #category : #serialization }
PBNoRepository >> stonOn: stonWriter [
	PBError new 
		signal: 'Cannot serialize a Project with no repository defined!'
]
