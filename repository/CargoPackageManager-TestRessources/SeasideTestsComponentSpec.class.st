Class {
	#name : #SeasideTestsComponentSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #'as yet unclassified' }
SeasideTestsComponentSpec >> dependencies [
	^ { #'Seaside-Component' -> #('=3.1') .
		#'Seaside-Tests-Core' -> #('=3.1') }
]

{ #category : #'as yet unclassified' }
SeasideTestsComponentSpec >> name [
	^ 'Seaside-Tests-Component'
]

{ #category : #'as yet unclassified' }
SeasideTestsComponentSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideTestsComponentSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideTestsComponentSpec >> version [
	^  '3.1.0'
]
