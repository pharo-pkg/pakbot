Class {
	#name : #SeasideRenderLoopSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #'as yet unclassified' }
SeasideRenderLoopSpec >> dependencies [
	^ { #'Seaside-Component' -> #('=3.1') .
		#'Seaside-Session' -> #('=3.1') }
]

{ #category : #'as yet unclassified' }
SeasideRenderLoopSpec >> name [
	^ 'Seaside-RenderLoop'
]

{ #category : #'as yet unclassified' }
SeasideRenderLoopSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideRenderLoopSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'Seaside-RenderLoop' .
		#versionString -> 'JohanBrichau.95' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideRenderLoopSpec >> srcArtifact [
	^ 'Seaside-RenderLoop-JohanBrichau.95'
]

{ #category : #'as yet unclassified' }
SeasideRenderLoopSpec >> version [
	^  '3.1'
]
