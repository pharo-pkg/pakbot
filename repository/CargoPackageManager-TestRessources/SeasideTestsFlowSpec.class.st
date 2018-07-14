Class {
	#name : #SeasideTestsFlowSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #'as yet unclassified' }
SeasideTestsFlowSpec >> dependencies [
	^ { #'Seaside-Flow' -> #('=3.1') .
		#'Seaside-Tests-Functional' -> #('=3.1') .
		#'Seaside-Tests-Continuation-Platform' -> #('=3.1') }

	"(package addDependency: 'Seaside-Tests-Pharo-Continuation')
		platform: #squeakCommon;
		yourself."
]

{ #category : #'as yet unclassified' }
SeasideTestsFlowSpec >> name [
	^ 'Seaside-Tests-Flow'
]

{ #category : #'as yet unclassified' }
SeasideTestsFlowSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideTestsFlowSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideTestsFlowSpec >> version [
	^  '3.1.0'
]
