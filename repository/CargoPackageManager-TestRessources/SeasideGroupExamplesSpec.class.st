Class {
	#name : #SeasideGroupExamplesSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #'as yet unclassified' }
SeasideGroupExamplesSpec >> dependencies [
	^ { #'Core' -> #('=3.1') .
		#'Seaside-Examples' -> #('=3.1') }
]

{ #category : #'as yet unclassified' }
SeasideGroupExamplesSpec >> name [
	^ 'Seaside-Group-Examples'
]

{ #category : #'as yet unclassified' }
SeasideGroupExamplesSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideGroupExamplesSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideGroupExamplesSpec >> version [
	^  '3.1.0'
]
