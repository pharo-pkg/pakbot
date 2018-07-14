Class {
	#name : #SeasideGroupDefaultSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #'as yet unclassified' }
SeasideGroupDefaultSpec >> dependencies [
	^ { #'Seaside-Welcome' -> #('=3.1') .
		#'Seaside-Examples' -> #('=3.1') .
		#'Zinc-Seaside' -> #('=3.1') }
]

{ #category : #'as yet unclassified' }
SeasideGroupDefaultSpec >> name [
	^ 'Seaside-Group-Default'
]

{ #category : #'as yet unclassified' }
SeasideGroupDefaultSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideGroupDefaultSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideGroupDefaultSpec >> version [
	^  '3.1'
]
