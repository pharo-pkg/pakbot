Class {
	#name : #SeasideTestsRenderLoopSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #'as yet unclassified' }
SeasideTestsRenderLoopSpec >> dependencies [
	^ { #'Seaside-RenderLoop' -> #('=3.1') .
		#'Seaside-Tests-Session' -> #('=3.1') }
]

{ #category : #'as yet unclassified' }
SeasideTestsRenderLoopSpec >> name [
	^ 'Seaside-Tests-RenderLoop'
]

{ #category : #'as yet unclassified' }
SeasideTestsRenderLoopSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideTestsRenderLoopSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideTestsRenderLoopSpec >> version [
	^  '3.1.0'
]
