Class {
	#name : #SeasideGroupCISpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #'as yet unclassified' }
SeasideGroupCISpec >> dependencies [
	^ { #'Tests' -> #('=3.1') .
		#'Zinc' -> #('=3.1') .
		#'Development Tests' -> #('=3.1') .
		#'REST Tests' -> #('=3.1') }
]

{ #category : #'as yet unclassified' }
SeasideGroupCISpec >> name [
	^ 'Seaside-Group-CI'
]

{ #category : #'as yet unclassified' }
SeasideGroupCISpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideGroupCISpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideGroupCISpec >> version [
	^  '3.1.0'
]
