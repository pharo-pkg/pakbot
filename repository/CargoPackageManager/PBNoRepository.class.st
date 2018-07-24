"
I am a null object representing the absence of repository configured for a project.
"
Class {
	#name : #PBNoRepository,
	#superclass : #CGOSourceRepository,
	#category : #'CargoPackageManager-Loading'
}

{ #category : #testing }
PBNoRepository >> isValidRepository [
	
	^ false
]
