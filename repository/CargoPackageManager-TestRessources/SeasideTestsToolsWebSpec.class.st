Class {
	#name : #SeasideTestsToolsWebSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #'as yet unclassified' }
SeasideTestsToolsWebSpec >> dependencies [
	^ { #'Seaside-Tools-Web' -> #('=3.1') .
		#'Seaside-Tests-Environment' -> #('=3.1') }
]

{ #category : #'as yet unclassified' }
SeasideTestsToolsWebSpec >> name [
	^ 'Seaside-Tests-Tools-Web'
]

{ #category : #'as yet unclassified' }
SeasideTestsToolsWebSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideTestsToolsWebSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideTestsToolsWebSpec >> version [
	^  '3.1.0'
]
