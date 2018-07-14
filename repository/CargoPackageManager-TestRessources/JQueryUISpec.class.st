Class {
	#name : #JQueryUISpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-JsJquery'
}

{ #category : #'as yet unclassified' }
JQueryUISpec >> dependencies [
	^ { #'JQuery-Core' -> #('=3.1') }
]

{ #category : #'as yet unclassified' }
JQueryUISpec >> name [
	^ 'JQuery-UI'
]

{ #category : #'as yet unclassified' }
JQueryUISpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
JQueryUISpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'JQuery-UI' .
		#versionString -> 'pmm.88' } asDictionary
]

{ #category : #'as yet unclassified' }
JQueryUISpec >> srcArtifact [
	^ 'JQuery-UI-pmm.88'
]

{ #category : #'as yet unclassified' }
JQueryUISpec >> version [
	^  '3.1'
]
