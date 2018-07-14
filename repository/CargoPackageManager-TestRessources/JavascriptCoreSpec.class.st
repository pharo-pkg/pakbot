Class {
	#name : #JavascriptCoreSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-JsJquery'
}

{ #category : #spec }
JavascriptCoreSpec >> dependencies [
	^ { #'Seaside-Core' -> #('=3.1') .
		#'Seaside-Canvas' -> #('=3.1') .
		#'Javascript-Core-Platform' -> #('=1') }

]

{ #category : #'as yet unclassified' }
JavascriptCoreSpec >> name [
	^ 'Javascript-Core'
]

{ #category : #'as yet unclassified' }
JavascriptCoreSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
JavascriptCoreSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'Javascript-Core' .
		#versionString -> 'pmm.95' } asDictionary
]

{ #category : #'as yet unclassified' }
JavascriptCoreSpec >> srcArtifact [
	^ 'Javascript-Core-pmm.95'
]

{ #category : #'as yet unclassified' }
JavascriptCoreSpec >> version [
	^  '3.1'
]
