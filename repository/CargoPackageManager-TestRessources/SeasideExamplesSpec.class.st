Class {
	#name : #SeasideExamplesSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #'as yet unclassified' }
SeasideExamplesSpec >> dependencies [
	^ {#'Seaside-Component' -> #('=3.1') .
		#'Seaside-Canvas' -> #('=3.1') .
		#'Seaside-Tools-Core' -> #('=3.1') }

]

{ #category : #'as yet unclassified' }
SeasideExamplesSpec >> name [
	^ 'Seaside-Examples'
]

{ #category : #'as yet unclassified' }
SeasideExamplesSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideExamplesSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'Seaside-Examples' .
		#versionString -> 'pmm.24' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideExamplesSpec >> srcArtifact [
	^ 'Seaside-Examples-pmm.24'
]

{ #category : #'as yet unclassified' }
SeasideExamplesSpec >> version [
	^  '3.1'
]
