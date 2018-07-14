Class {
	#name : #SeasidePharoContinuationSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Pharo'
}

{ #category : #'as yet unclassified' }
SeasidePharoContinuationSpec >> name [
	^ 'Seaside-Pharo-Continuation'
]

{ #category : #'as yet unclassified' }
SeasidePharoContinuationSpec >> platformRequirements [
	^ #(#squeakCommon)
]

{ #category : #spec }
SeasidePharoContinuationSpec >> provisions [
	^ #(#'Seaside-Continuation-Platform@1.0')
]

{ #category : #'as yet unclassified' }
SeasidePharoContinuationSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasidePharoContinuationSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'Seaside-Pharo-Continuation' .
		#versionString -> 'lr.5' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasidePharoContinuationSpec >> srcArtifact [
	^ 'Seaside-Pharo-Continuation-lr.5'
]

{ #category : #'as yet unclassified' }
SeasidePharoContinuationSpec >> version [
	^  '3.1'
]
