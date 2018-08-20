"
I am a null object representing the absence of repository configured for a project.
"
Class {
	#name : #PBNoRepository,
	#superclass : #CGOSourceRepository,
	#category : #'CargoPackageManager-Loading'
}

{ #category : #'package-synchronization' }
PBNoRepository >> addPackage: aPBPackage [ 
	
	"Nothing, I'm not a repository"
]

{ #category : #testing }
PBNoRepository >> isValidRepository [
	
	^ false
]
