Class {
	#name : #SeasideTestsSessionSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #'as yet unclassified' }
SeasideTestsSessionSpec >> dependencies [
	^ { #'Seaside-Tests-Core' -> #('=3.1') .
		#'Seaside-Session' -> #('=3.1') .
		#'Seaside-Tests-Canvas' -> #('=3.1') }
]

{ #category : #'as yet unclassified' }
SeasideTestsSessionSpec >> name [
	^ 'Seaside-Tests-Session'
]

{ #category : #'as yet unclassified' }
SeasideTestsSessionSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideTestsSessionSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideTestsSessionSpec >> version [
	^  '3.1.0'
]
