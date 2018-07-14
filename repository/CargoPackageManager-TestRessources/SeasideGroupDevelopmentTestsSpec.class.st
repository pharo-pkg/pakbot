Class {
	#name : #SeasideGroupDevelopmentTestsSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #'as yet unclassified' }
SeasideGroupDevelopmentTestsSpec >> dependencies [
	^ { #'Development' -> #('=3.1') .
		#'Core' -> #('=3.1') .
		#'Seaside-Tests-Development' -> #('=3.1') }
]

{ #category : #'as yet unclassified' }
SeasideGroupDevelopmentTestsSpec >> name [
	^ 'Seaside-Group-DevelopmentTests'
]

{ #category : #'as yet unclassified' }
SeasideGroupDevelopmentTestsSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideGroupDevelopmentTestsSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideGroupDevelopmentTestsSpec >> version [
	^  '3.1.0'
]
