Class {
	#name : #SeasideTestsExamplesSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #'as yet unclassified' }
SeasideTestsExamplesSpec >> dependencies [
	^ { #'Seaside-Examples' -> #('=3.1') .
		#'Seaside-Tests-Environment' -> #('=3.1') }
]

{ #category : #'as yet unclassified' }
SeasideTestsExamplesSpec >> name [
	^ 'Seaside-Tests-Examples'
]

{ #category : #'as yet unclassified' }
SeasideTestsExamplesSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideTestsExamplesSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideTestsExamplesSpec >> version [
	^  '3.1.0'
]
