Class {
	#name : #SeasideCanvasSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #spec }
SeasideCanvasSpec >> dependencies [
	^ { #'Seaside-Core' -> #('=3.1') .
		 #'Seaside-Canvas-Platform' -> #('=1.0') }
]

{ #category : #'as yet unclassified' }
SeasideCanvasSpec >> name [
	^ 'Seaside-Canvas'
]

{ #category : #'as yet unclassified' }
SeasideCanvasSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideCanvasSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'Seaside-Canvas' .
		#versionString -> 'pmm.127' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideCanvasSpec >> srcArtifact [
	^ 'Seaside-Canvas-pmm.127'
]

{ #category : #'as yet unclassified' }
SeasideCanvasSpec >> version [
	^  '3.1'
]
