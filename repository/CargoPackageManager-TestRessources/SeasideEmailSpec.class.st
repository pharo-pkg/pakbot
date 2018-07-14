Class {
	#name : #SeasideEmailSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #'as yet unclassified' }
SeasideEmailSpec >> dependencies [
	^ { #'Seaside-Core' -> #('=3.1') .
		#'Seaside-Email-Platform' -> #('=3.1') }
"Seaside-Pharo-Email #squeakCommon;"

]

{ #category : #'as yet unclassified' }
SeasideEmailSpec >> name [
	^ 'Seaside-Email'
]

{ #category : #'as yet unclassified' }
SeasideEmailSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideEmailSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideEmailSpec >> version [
	^  '3.1.0'
]
