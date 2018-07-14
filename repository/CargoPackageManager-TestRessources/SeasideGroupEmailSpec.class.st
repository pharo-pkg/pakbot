Class {
	#name : #SeasideGroupEmailSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #'as yet unclassified' }
SeasideGroupEmailSpec >> dependencies [
	^ { #'Seaside-Email' -> #('=3.1') }

]

{ #category : #'as yet unclassified' }
SeasideGroupEmailSpec >> name [
	^ 'Seaside-Group-Email'
]

{ #category : #'as yet unclassified' }
SeasideGroupEmailSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideGroupEmailSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideGroupEmailSpec >> version [
	^  '3.1.0'
]
