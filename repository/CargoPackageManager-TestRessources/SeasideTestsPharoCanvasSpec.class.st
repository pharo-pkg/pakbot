Class {
	#name : #SeasideTestsPharoCanvasSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Pharo'
}

{ #category : #'as yet unclassified' }
SeasideTestsPharoCanvasSpec >> dependencies [
	"(package addDependency: 'Seaside-Tests-Canvas')
		version: '';
		yourself."
	
	^ #()
]

{ #category : #'as yet unclassified' }
SeasideTestsPharoCanvasSpec >> name [
	^ 'Seaside-Tests-Pharo-Canvas'
]

{ #category : #'as yet unclassified' }
SeasideTestsPharoCanvasSpec >> platformRequirements [
	^ #(#squeakCommon)
]

{ #category : #'as yet unclassified' }
SeasideTestsPharoCanvasSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideTestsPharoCanvasSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideTestsPharoCanvasSpec >> version [
	^  '3.1.0'
]
