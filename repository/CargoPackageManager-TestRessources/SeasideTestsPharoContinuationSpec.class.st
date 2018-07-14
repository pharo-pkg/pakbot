Class {
	#name : #SeasideTestsPharoContinuationSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Pharo'
}

{ #category : #'as yet unclassified' }
SeasideTestsPharoContinuationSpec >> dependencies [
	^ { #'Seaside-Pharo-Continuation' -> #('=3.1') }
]

{ #category : #'as yet unclassified' }
SeasideTestsPharoContinuationSpec >> name [
	^ 'Seaside-Tests-Pharo-Continuation'
]

{ #category : #'as yet unclassified' }
SeasideTestsPharoContinuationSpec >> platformRequirements [
	^ #(#squeakCommon)
]

{ #category : #'as yet unclassified' }
SeasideTestsPharoContinuationSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideTestsPharoContinuationSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideTestsPharoContinuationSpec >> version [
	^  '3.1.0'
]
