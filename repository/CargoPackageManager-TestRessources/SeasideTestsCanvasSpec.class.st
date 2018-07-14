Class {
	#name : #SeasideTestsCanvasSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #'as yet unclassified' }
SeasideTestsCanvasSpec >> dependencies [
	^ { #'Seaside-Tests-Core' -> #('=3.1') .
		#'Seaside-Canvas' -> #('=3.1') .
		#'Seaside-Tests-Canvas-Platform' -> #('=3.1') }
		
	 " Seaside-Tests-Pharo-Canvas platform: #squeakCommon;"
	
]

{ #category : #'as yet unclassified' }
SeasideTestsCanvasSpec >> name [
	^ 'Seaside-Tests-Canvas'
]

{ #category : #'as yet unclassified' }
SeasideTestsCanvasSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideTestsCanvasSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideTestsCanvasSpec >> version [
	^  '3.1.0'
]
