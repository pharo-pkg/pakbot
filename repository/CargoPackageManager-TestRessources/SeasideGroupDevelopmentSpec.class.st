Class {
	#name : #SeasideGroupDevelopmentSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #'as yet unclassified' }
SeasideGroupDevelopmentSpec >> dependencies [
	^ { #'Core' -> #('=3.1') .
		#'Seaside-Development' -> #('=3.1') }
]

{ #category : #'as yet unclassified' }
SeasideGroupDevelopmentSpec >> name [
	^ 'Seaside-Group-Development'
]

{ #category : #'as yet unclassified' }
SeasideGroupDevelopmentSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideGroupDevelopmentSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideGroupDevelopmentSpec >> version [
	^  '3.1.0'
]
